//
//  ContentView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import SwiftUI
import Factory

struct ContentView: View {
    
    @LazyInjected(\.deeplinkCombiner) var deeplinkCombiner
    @InjectedObject(\.treeDataManager) var treeDataManager
    
    @State var isPickerPresented = false
    
    
    var body: some View {
        NavigationSplitView {
            DeeplinkTreeView()
                .frame(minWidth: 250)
                .navigationTitle("Structure")
        } detail: {
            DeeplinkDetailsView(
                viewModel: DeeplinkDetailsViewModel()
            )
            .navigationTitle("")
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                AppToolBarView()
            }
        }
        .frame(minHeight: 400)
    }
}

#Preview {
    ContentView()
}
