//
//  DeeplinkTreeView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import SwiftUI
import Factory

struct DeeplinkTreeView: View {
    
    @Injected(\.treeItemViewFactory) var treeItemViewFactory
    @InjectedObject(\.treeDataManager) var treeManager
    @StateObject var viewModel = DeeplinkTreeViewModel()
    
    var body: some View {
        List(treeManager.treeList.children, id: \.value, children: \.optionalChildren) { node in
            AnyView(
                treeItemViewFactory.createView(
                    for: node,
                    onSelection: {
                        treeManager.selectedNode = node
                        if case .deeplink = node.value {
                            treeManager.selectedDeeplink = node
                        }
                    },
                    onPerformAction: { action in
                        Task {
                            await treeManager.performAction(action, on: node)
                        }
                    }
                )
            )
        }
        .listRowBackground(Color.red)
    }
}

#Preview {
    DeeplinkTreeView()
        .frame(width: 250)
}
