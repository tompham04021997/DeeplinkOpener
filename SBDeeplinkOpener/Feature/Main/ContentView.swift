//
//  ContentView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.deeplinkCombiner) var deeplinkCombiner
    @EnvironmentObject var treeManager: TreeDataManager
    
    @StateObject var viewModel = ContentViewModel()
    @State var isPickerPresented = false
    
    
    var body: some View {
        NavigationSplitView {
            DeeplinkTreeView()
            .frame(minWidth: 250)
            .navigationTitle("Structure")
        } detail: {
            DeeplinkDetailsView(
                viewModel: DeeplinkDetailsViewModel(
                    treeManager: treeManager,
                    selectedSimulator: viewModel.selectedSimulator.entity,
                    deeplinkCombiner: deeplinkCombiner
                )
            )
            .navigationTitle("")
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                
                SimulatorInfoView(viewModel: viewModel.selectedSimulator, selectionSimulator: $viewModel.selectedSimulator, onSelection: {
                    isPickerPresented = true
                })
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .popover(isPresented: $isPickerPresented) {
                    SimulatorListView(
                        simulators: viewModel.simulatorViewModels,
                        selectionSimulator: $viewModel.selectedSimulator
                    ) {
                        isPickerPresented = false
                    }
                    .frame(minWidth: 300, minHeight: 400)
                    
                }
            }
        }
        .frame(minHeight: 400)
    }
}

#Preview {
    ContentView()
}
