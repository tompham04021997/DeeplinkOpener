 //
//  SimulatorListViewModel.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 18/03/2024.
//

import Foundation
import Factory
import Combine

final class SimulatorListViewModel: ObservableObject {
    
    @Published var items: [SimulatorInfoViewModel] = []
    @Published var selectedItem: SimulatorInfoViewModel = .init(
        entity: Simulator(
            version: .empty,
            name: .empty,
            uuid: .empty,
            state: .shutdown
        )
    )
    
    @LazyInjected(\.simulatorDataObserverManager) var simulatorDataObserverManager
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
        simulatorDataObserverManager
            .$selectedSimulator
            .compactMap { $0 }
            .removeDuplicates()
            .map { SimulatorInfoViewModel(entity: $0) }
            .receive(on: DispatchQueue.main)
            .assign(to: \.selectedItem, on: self)
            .store(in: &cancellables)
            
        simulatorDataObserverManager
            .$simulators
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .map { simulators -> [SimulatorInfoViewModel] in
                return simulators.map { SimulatorInfoViewModel(entity: $0) }
            }
            .assign(to: \.items, on: self)
            .store(in: &cancellables)
    }
    
    func updateSelectedSimulator(_ simulator: Simulator) {
        simulatorDataObserverManager.selectedSimulator = simulator
    }
}
