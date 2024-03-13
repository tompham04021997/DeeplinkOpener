//
//  DeeplinkDetailsViewModel.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import SwiftUI

enum DeeplinkDetailsDataState {
    case empty
    case loaded(data: DeeplinkEntity)
    case updated
}

final class DeeplinkDetailsViewModel: ObservableObject {
    
    private let deeplinkCombiner: DeeplinkCombinerProtocol
    private var deeplinkEntity: DeeplinkEntity?
    let selectedSimulator: Simulator
    
    @Published var dataState: DeeplinkDetailsDataState = .empty
    
    init(
        deeplinkEntity: DeeplinkEntity?,
        selectedSimulator: Simulator,
        deeplinkCombiner: DeeplinkCombinerProtocol
    ) {
        self.deeplinkEntity = deeplinkEntity
        self.selectedSimulator = selectedSimulator
        self.deeplinkCombiner = deeplinkCombiner
        
        loadDataState()
    }

    func loadDataState() {
        if let deeplinkEntity {
            dataState = .loaded(data: deeplinkEntity)
        }
    }
    
    var deeplink: String {
        guard let entity = deeplinkEntity else {
            return ""
        }
        
        return deeplinkCombiner.combineToDeeplink(fromEntity: entity)
    }
    
    var schema: String {
        return (deeplinkEntity?.schema).orEmpty
    }
    
    var path: String {
        return (deeplinkEntity?.path).orEmpty
    }
    
    var params: [DeeplinkParamEntity] {
        
        guard let params = deeplinkEntity?.params else { return [] }
        return params
    }
    
    func updateDeeplinkParams(value: [DeeplinkParamEntity]) {
        deeplinkEntity?.params = value
        dataState = .updated
    }
    
    func updateDeeplinkSchema(value: String) {
        deeplinkEntity?.schema = value
        dataState = .updated
    }
    
    func updateDeeplinkPath(value: String) {
        deeplinkEntity?.path = value
        dataState = .updated
    }
    
    func removeDeeplinkParam(at index: Int) {
        guard index >= .zero,
              index < params.count,
              var editableParams = deeplinkEntity?.params
        else { return }
        
        editableParams.remove(at: index)
        
        if editableParams.isEmpty {
            editableParams.append(.empty())
        }
        
        updateDeeplinkParams(value: editableParams)
    }
    
    func addDeeplinkParam(at index: Int) {
        guard var editableParams = deeplinkEntity?.params else {
            return
        }
        
        editableParams.insert(.empty(), at: index + 1)
        updateDeeplinkParams(value: editableParams)
    }
}
