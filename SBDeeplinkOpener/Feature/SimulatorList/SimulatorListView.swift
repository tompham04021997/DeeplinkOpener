//
//  SimulatorListView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import SwiftUI

struct SimulatorListView: View {
    
    let simulators: [SimulatorInfoViewModel]
    @Binding var selectionSimulator: SimulatorInfoViewModel
    var onSelection: VoidCallBack?
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: .zero) {
                    ForEach(simulators, id: \.id) { simulator in
                        SimulatorInfoView(
                            viewModel: simulator,
                            selectionSimulator: $selectionSimulator, onSelection: onSelection).tag(simulator.id)
                    }
                }
            }
        }
    }
}

#Preview {
    SimulatorListView(
        simulators: SimulatorManager().getAvailableSimulators().map { .init(entity: $0)},
        selectionSimulator: .constant(.init(entity: SimulatorManager().getAvailableSimulators().first!))
    )
}
