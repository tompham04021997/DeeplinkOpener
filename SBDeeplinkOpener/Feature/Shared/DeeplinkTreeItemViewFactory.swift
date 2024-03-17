//
//  DeeplinkTreeItemViewFactory.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 14/03/2024.
//

import SwiftUI

final class DeeplinkTreeItemViewFactory {}

extension DeeplinkTreeItemViewFactory: DeeplinkTreeItemViewFactoryProtocol {
    
    @ViewBuilder
    func createView(
        for node: TreeNode<DirectoryType>,
        selection: TreeNode<DirectoryType>?,
        onSelection: @escaping VoidCallBack,
        onPerformAction: @escaping (TreeDataInteractionActionType) -> Void
    ) -> some View {
        Group {
            switch node.value {
            case .folder(let name, _):
                TreeFolderView(
                    title: name
                )
            case .deeplink(let data):
                DeeplinkFileView(
                    title: data.name
                )
            }
        }
        .onTapGesture {
            onSelection()
        }
        .background(makeBackgroundColor(for: node, selection: selection))
        .clipShape(RoundedRectangle(cornerRadius: .dimensionSpace3))
        .contextMenu(
            ContextMenu(
                menuItems: {
                    if case .folder = node.value {
                        Menu(L10n.Common.Action.create) {
                            Button("Folder") {
                                onPerformAction(.createFolder)
                            }
                            Button("Deeplink") {
                                onPerformAction(.createDeeplink)
                            }
                        }
                    }
                    
                    Button(L10n.Common.Action.remove) {
                        onPerformAction(.removeNode(node: node))
                    }
                    
                    Button(L10n.Common.Action.rename) {
                        
                    }
                }
            )
        )
    }
    
    private func makeBackgroundColor(for node: TreeNode<DirectoryType>, selection: TreeNode<DirectoryType>?) -> Color {
        if node.nodeID == selection?.nodeID {
            return Color.blue
        }
        
        return Color.clear
    }
}
