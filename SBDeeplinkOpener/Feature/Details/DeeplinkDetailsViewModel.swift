//
//  DeeplinkDetailsViewModel.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import SwiftUI
import Combine

enum DeeplinkDetailsDataState {
    case initialized
    case loaded
}

final class DeeplinkDetailsViewModel: ObservableObject {
    
    @ObservedObject var treeManager: TreeDataManager
    
    // MARK: - Publishers
    
    // MARK; - Output
    @Published var dataState: DeeplinkDetailsDataState = .initialized
    @Published var deeplinkSchema: String = .empty
    @Published var deeplinkPath: String = .empty
    @Published var deeplinkParams = [DeeplinkParamEntity]()
    @Published var deeplink: String = .empty
    @Published var isSavingButtonEnabled = false
    
    // MARK: - Input
    
    @Published var onSaveDeeplinkData = false
    
    // MARK: - Data
    private var originalDeeplinkEntity: DeeplinkEntity?
    private var deeplinkID: String = .empty
    private var deeplinkName: String = .empty
    let selectedSimulator: Simulator
    
    // MARK: - Dependencies
    
    private var cancellables = Set<AnyCancellable>()
    private let deeplinkParser = DeeplinkParser()
    private let deeplinkCombiner: DeeplinkCombinerProtocol
    
    init(
        treeManager: TreeDataManager,
        selectedSimulator: Simulator,
        deeplinkCombiner: DeeplinkCombinerProtocol
    ) {
        self.selectedSimulator = selectedSimulator
        self.deeplinkCombiner = deeplinkCombiner
        self.treeManager = treeManager
        
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
            .receive(on: DispatchQueue.main)
            .handleEvents(
                receiveOutput: { [weak self] entity in
                    guard let self else { return }
                    self.isSavingButtonEnabled = entity != self.originalDeeplinkEntity
                }
            )
            .receive(on: DispatchQueue.global(qos: .default))
            .compactMap { [weak self] entity -> String? in
                return self?.deeplinkCombiner.combineToDeeplink(fromEntity: entity)
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.deeplink, on: self)
            .store(in: &cancellables)
        
        $onSaveDeeplinkData
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
                    await self.treeManager.updateSelectedDeeplinkNode(value: entity)
                }
            }
            .store(in: &cancellables)
        
        treeManager.$selectedDeeplinkNode
            .sink { [weak self] node in
                guard let self else { return }
                switch node?.value {
                case .deeplink(let data):
                    self.initializeDataIfPossible(withEntity: data)
                    self.dataState = .loaded
                    
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
    
    private func initializeDataIfPossible(withEntity entity: DeeplinkEntity?) {
        originalDeeplinkEntity = entity
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
        }
    }
}
