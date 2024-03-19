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
    
    var body: some View {
        List(treeManager.treeList.children, id: \.value, children: \.optionalChildren) { node in
            AnyView(
                treeItemViewFactory.createView(
                    for: node,
                    selection: treeManager.selectedNode,
                    onSelection: {
                        treeManager.selectedNode = node
                    },
                    onPerformAction: { action in
                        Task {
                            await treeManager.performAction(action, on: node)
                        }
                    }
                )
            )
        }
        .listRowSeparator(.hidden)
        .listRowInsets(.none)
        .listStyle(.automatic)
    }
}

#Preview {
    DeeplinkTreeView()
        .frame(width: 250)
}
