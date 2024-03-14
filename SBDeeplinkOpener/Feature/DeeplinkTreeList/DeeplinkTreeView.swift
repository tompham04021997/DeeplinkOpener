//
//  DeeplinkTreeView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import SwiftUI

struct DeeplinkTreeView: View {
    
    private let deeplinkTreeItemFactory: any DeeplinkTreeItemViewFactoryProtocol = DeeplinkTreeItemViewFactory()
    
    @EnvironmentObject var treeManager: TreeDataManager
    @StateObject var viewModel = DeeplinkTreeViewModel()
    
    var body: some View {
        List(treeManager.treeList.nodes, id: \.value, children: \.optionalChildren) { node in
            AnyView(
                deeplinkTreeItemFactory.createView(
                    for: node,
                    onSelection: {
                        treeManager.selectedNode = node
                        if case .deeplink = node.value {
                            treeManager.selectedDeeplinkNode = node
                        }
                    },
                    onPerformAction: { action in
                        treeManager.performAction(action, on: node)
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
