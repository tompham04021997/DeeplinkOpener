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
    @State var selectedDeeplink: DeeplinkEntity?
    
    @State var isPickerPresented = false
    
    var body: some View {
        NavigationSplitView {
            DeeplinkTreeView(
                onSeletionItem: { type in
                    switch type {
                    case .folder(let name, let id):
                        return
                    case .deeplink(let data):
                        selectedDeeplink = data
                    }
                }
            )
                .frame(minWidth: 250)
                .navigationTitle("Structure")
        } detail: {
            DeeplinkDetailsView(
                deeplinkEntity: $selectedDeeplink,
                selectedSimulator: selectedSimulator.entity
            )
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
