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
        onSelection: @escaping VoidCallBack,
        onPerformAction: @escaping (TreeDataInteractionActionType) -> Void
    ) -> some View {
        switch node.value {
        case .folder(let name, let id):
            TreeFolderView(
                title: name,
                onFolderNameChanged: { newName in
                    onPerformAction(.updateNodeValue(newValue: .folder(name: newName, id: id)))
                }
            )
            .onTapGesture {
                onSelection()
            }
            .contextMenu(
                ContextMenu(
                    menuItems: {
                        Menu("Create") {
                            Button("Folder") {
                                onPerformAction(.createFolder)
                            }
                            Button("Deeplink") {
                                onPerformAction(.createDeeplink)
                            }
                        }
                        
                        Button("Remove") {
                            onPerformAction(.removeNode(node: node))
                        }
                    }
                )
            )
        case .deeplink(let data):
            DeeplinkFileView(
                title: data.name,
                onFileNameChanged: {
                    newName in
                    data.name = newName
                    onPerformAction(
                        .updateNodeValue(
                            newValue: .deeplink(
                                data: data
                            )
                        )
                    )
                }
            )
            .onTapGesture {
                onSelection()
            }
            .contextMenu(
                ContextMenu(
                    menuItems: {
                        Button("Remove") {
                            onPerformAction(.removeNode(node: node))
                        }
                    }
                )
            )
        }
    }
}
