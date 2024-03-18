//
//  DeeplinkDetailsViewModel.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import SwiftUI
import Combine
import Factory

enum DeeplinkDetailsDataState {
    case empty
    case loaded
}

final class DeeplinkDetailsViewModel: ObservableObject {
    
    // MARK: - Publishers
    
    // MARK: - Output
    
    @Published var dataState: DeeplinkDetailsDataState = .empty
    @Published var deeplinkSchema: String = .empty
    @Published var deeplinkPath: String = .empty
    @Published var deeplinkParams = [DeeplinkParamEntity]()
    @Published var deeplink: String = .empty
    @Published var isSavingButtonEnabled = false
    
    // MARK: - Input
    
    @Published var onSaveDeeplinkDataTrigger = false
    @Published var onOpenDeeplinkTrigger = false
    @Published var onCopyDeeplinkTrigger = false
    @Published var onImportedDeeplinkTrigger = ""
    
    // MARK: - Data
    
    @Published private var editableDeeplinkEntity: DeeplinkEntity?
    
    private var deeplinkID: String = .empty
    private var deeplinkName: String = .empty
    
    // MARK: - Dependencies
    private var cancellables = Set<AnyCancellable>()
    
    @LazyInjected(\.deeplinkParser) var deeplinkParser
    @LazyInjected(\.deeplinkCombiner) var deeplinkCombiner
    @LazyInjected(\.deeplinkOpener) var deeplinkOpener
    @LazyInjected(\.treeDataManager) var treeDataManager
    @LazyInjected(\.simulatorDataObserverManager) var simulatorDataObserverManager
    
    init() {
        setupBindingDataFlow()
    }
}

// MARK: - Privates

extension DeeplinkDetailsViewModel {
    
    private func setupBindingDataFlow() {
        $deeplinkSchema
            .removeDuplicates()
            .combineLatest(
                $deeplinkPath
                    .removeDuplicates(),
                $deeplinkParams
            )
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.global(qos: .background))
            .compactMap { [weak self] schema, path, params -> DeeplinkEntity? in
                guard let self else { return nil }
                return DeeplinkEntity(
                    id: deeplinkID,
                    name: deeplinkName,
                    schema: schema,
                    path: path,
                    params: params
                )
            }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .handleEvents(
                receiveOutput: { [weak self] entity in
                    guard let self else { return }
                    self.editableDeeplinkEntity = entity
                }
            )
            .receive(on: DispatchQueue.global(qos: .default))
            .compactMap { [weak self] entity -> String? in
                return self?.deeplinkCombiner.combineToDeeplink(fromEntity: entity)
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.deeplink, on: self)
            .store(in: &cancellables)
        
        $onSaveDeeplinkDataTrigger
            .receive(on: DispatchQueue.global(qos: .background))
            .filter { $0 }
            .compactMap { [weak self] _ -> DeeplinkEntity? in
                guard let self else { return nil }
                return DeeplinkEntity(
                    id: self.deeplinkID,
                    name: self.deeplinkName,
                    schema: self.deeplinkSchema,
                    path: self.deeplinkPath,
                    params: self.deeplinkParams
                )
            }
            .sink { [weak self] entity in
                Task { [weak self] in
                    guard let self else { return }
                    await self.treeDataManager.updateDeeplinkData(entity)
                }
            }
            .store(in: &cancellables)
        
        $onOpenDeeplinkTrigger
            .receive(on: DispatchQueue.global(qos: .background))
            .filter { $0 }
            .map { _ in (self.deeplink, self.simulatorDataObserverManager.selectedSimulator) }
            .sink(receiveValue: { [weak self] deeplink, device in
                guard let deeplinkOpener = self?.deeplinkOpener, let device else { return }
                deeplinkOpener.openDeeplink(deeplink, on: device)
            })
            .store(in: &cancellables)
        
        $onCopyDeeplinkTrigger
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .map { _ in  self.deeplink }
            .sink(receiveValue: { deeplink in
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setString(deeplink, forType: .string)
            })
            .store(in: &cancellables)
        
        $onImportedDeeplinkTrigger
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] importedDeeplink in
                self?.analyzingImportedDeeplink(importedDeeplink)
            })
            .store(in: &cancellables)
        
        treeDataManager.$selectedDeeplink
            .compactMap { node -> DeeplinkEntity? in
                switch node?.value {
                case .deeplink(let data):
                    return data
                    
                default:
                    return nil
                }
            }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self else { return }
                self.initializeDataIfPossible(withEntity: data)
            }
            .store(in: &cancellables)
        
        treeDataManager.$selectedDeeplink
            .compactMap { node -> DeeplinkEntity? in
                if case .deeplink(let data) = node?.value {
                    return data
                }
                
                return nil
            }
            .combineLatest(
                $editableDeeplinkEntity
            )
            .map { lhsEntity, rhsEntity -> Bool in
                return lhsEntity != rhsEntity
            }
            .removeDuplicates()
            .assign(to: \.isSavingButtonEnabled, on: self)
            .store(in: &cancellables)
    }
    
    private func initializeDataIfPossible(withEntity entity: DeeplinkEntity?) {
        if let entity {
            deeplinkID = entity.id
            deeplinkName = entity.name
            deeplinkSchema = entity.schema
            deeplinkPath = entity.path
            
            if let params = entity.params, !params.isEmpty {
                deeplinkParams = params
            } else {
                deeplinkParams = [.empty()]
            }
            deeplink = deeplinkCombiner.combineToDeeplink(fromEntity: entity)
            moveDateState(to: .loaded)
        } else {
            moveDateState(to: .empty)
        }
    }
    
    private func moveDateState(to newState: DeeplinkDetailsDataState) {
        self.dataState = newState
    }
    
    private func analyzingImportedDeeplink(_ importedDeeplink: String) {
        if let schema = try? deeplinkParser.getSchema(fromDeeplink: importedDeeplink) {
            self.deeplinkSchema = schema
        }
        
        if let path = try? deeplinkParser.getPath(fromDeeplink: importedDeeplink) {
            self.deeplinkPath = path
        }
        
        if let params = try? deeplinkParser.getParams(fromDeeplink: importedDeeplink) {
            self.deeplinkParams = params
        }
    }
}
