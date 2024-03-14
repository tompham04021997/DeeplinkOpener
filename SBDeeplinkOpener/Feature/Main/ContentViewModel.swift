//
//  ContentViewModel.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 13/03/2024.
//

import Foundation
import SwiftUI
import Combine

final class ContentViewModel: ObservableObject {
    
    @Published var simulatorViewModels: [SimulatorInfoViewModel] = []
    @Published var selectedSimulator: SimulatorInfoViewModel = SimulatorInfoViewModel(
        entity: Simulator(
            version: "Unknown",
            name: "Unknown",
            uuid: "Unknown",
            state: .shutdown
        )
    )
    
    @Published var selectionDeeplink: DeeplinkEntity?
    
    private var cancellables = Set<AnyCancellable>()
    private let deviceManager: SimulatorManagerProtocol = SimulatorManager()
    private let dataStorageService: DeeplinkDataStorageServiceProtocol = LocalDataStorageService()
    
    init() {
        simulatorViewModels = deviceManager.getAvailableSimulators()
            .map { SimulatorInfoViewModel(entity: $0) }
        
        if let firstAvailableSimulator = simulatorViewModels.first {
            selectedSimulator = firstAvailableSimulator
        }
    }
}
