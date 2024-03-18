//
//  SimulatorDataManager.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 18/03/2024.
//

import Combine
import SwiftUI
import Factory

final class SimulatorDataObserverManager: ObservableObject {
    
    @LazyInjected(\.simulatorManager) var manager
    
    @Published var simulators: [Simulator] = []
    @Published var selectedSimulator: Simulator?
    
    init() {
        simulators = manager.getAvailableSimulators()
        
        if let availableBootedSimulator = simulators.first(where: { $0.state == .booted }) {
            selectedSimulator = availableBootedSimulator
        } else {
            selectedSimulator = simulators.first
        }
    }
}
