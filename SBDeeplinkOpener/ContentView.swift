//
//  ContentView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedSimulator: SimulatorInfoViewModel = SimulatorInfoViewModel(
        entity: Simulator(
            version: "16.0",
            name: "iPhone 12",
            uuid: "BCDEF12-34567890ABCDEF12",
            state: .booted
        )
    )
    let simulators = SimulatorManager().getAvailableSimulators().map { SimulatorInfoViewModel(entity: $0) }
    
    @State var isPickerPresented = false
    
    var body: some View {
        NavigationSplitView {
            DeeplinkListView()
                .frame(minWidth: 250, minHeight: 450)
                .animation(.easeInOut, value: "")
                .navigationTitle("Deeplink")
        } detail: {
            DeeplinkDetailsView()
                .navigationTitle("")
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                
                SimulatorInfoView(viewModel: selectedSimulator, selectionSimulator: $selectedSimulator, onSelection: {
                    isPickerPresented = true
                })
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .popover(isPresented: $isPickerPresented) {
                    SimulatorListView(simulators: simulators, selectionSimulator: $selectedSimulator) {
                        isPickerPresented = false
                    }
                    .frame(minWidth: 300, minHeight: 400)
                    
                }
            }
        }
        .frame(minWidth: 800)
    }
}

#Preview {
    ContentView()
}
