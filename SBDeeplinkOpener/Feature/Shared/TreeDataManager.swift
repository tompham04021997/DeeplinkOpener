//
//  TreeDataManager.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 14/03/2024.
//

import SwiftUI

@MainActor
final class TreeDataManager: ObservableObject {

    @Published var treeList: TreeList<DeeplinkTreeItemType> = TreeList()
    @Published var selectedDeeplinkNode: TreeNode<DeeplinkTreeItemType>?
    @Published var selectedNode: TreeNode<DeeplinkTreeItemType>?
    @Published var preparingNode: TreeNode<DeeplinkTreeItemType>?
    
    private let databaseService: DeeplinkDataStorageServiceProtocol = LocalDataStorageService()
    
    init() {
        Task {
            let data = await databaseService.read()
            if data.isEmpty {
                treeList = TreeList([TreeNode(.folder(name: "Deeplinks", id: UUID().uuidString))])
            } else {
                treeList = data
            }
        }
    }
    
    func addChild(child: TreeNode<DeeplinkTreeItemType>, toNode node: TreeNode<DeeplinkTreeItemType>) async {
        var editableNode = node
        treeList.addChill(child, toNode: &editableNode)
        _ = await databaseService.save(tree: treeList)
    }
    
    func updateSelectedDeeplinkNode(value: DeeplinkEntity) async {
        guard var editableNode = selectedDeeplinkNode else { return }
        editableNode.value = .deeplink(data: value)
        selectedDeeplinkNode = editableNode
        treeList.updateNode(editableNode)
        _ = await databaseService.save(tree: treeList)
    }
    
    func performAction(_ action: TreeDataInteractionActionType, on node: TreeNode<DeeplinkTreeItemType>) {
        
        var editableNode = node
        switch action {
        case .createFolder:
            editableNode.addChill(TreeNode(.folder(name: "Folder", id: UUID().uuidString)))
            treeList.updateNode(editableNode)

        case .createDeeplink:
            editableNode.addChill(
                TreeNode(
                    .deeplink(
                        data: .init(
                            name: "Deeplink",
                            schema: "shopback" ,
                            path: .empty,
                            params: [.empty()]
                        )
                    )
                )
            )
            treeList.updateNode(editableNode)
            
        case .updateNodeValue(let newValue):
            editableNode.value = newValue
            treeList.updateNode(editableNode)
            
        case .removeNode(let node):
            treeList.removeNode(node)
            if treeList.isEmpty {
                treeList = TreeList([
                    TreeNode(.folder(name: "Deeplinks", id: UUID().uuidString))
                ])
            }
        }
        
        Task {
            await databaseService.save(tree: treeList)
        }
    }
    
    private func createNewNode(for action: TreeDataInteractionActionType) -> TreeNode<DeeplinkTreeItemType>? {
        switch action {
        case .createFolder:
            return TreeNode<DeeplinkTreeItemType>(
                .folder(
                    name: "Folder",
                    id: UUID().uuidString
                )
            )
        case .createDeeplink:
            return TreeNode<DeeplinkTreeItemType>(
                DeeplinkTreeItemType.deeplink(
                    data: .init(
                        name: "Deeplink",
                        schema: "shopback" ,
                        path: .empty,
                        params: [.empty()]
                    )
                )
            )
            
        default:
            return nil
        }
    }
}
