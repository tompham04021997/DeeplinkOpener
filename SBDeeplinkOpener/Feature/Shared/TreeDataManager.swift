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
                treeList = .defaultList()
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
            editableNode.addChill(.folderNode())
            treeList.updateNode(editableNode)

        case .createDeeplink:
            editableNode.addChill(.deeplinkNode())
            treeList.updateNode(editableNode)
            
        case .updateNodeValue(let newValue):
            editableNode.value = newValue
            treeList.updateNode(editableNode)
            
        case .removeNode(let node):
            treeList.removeNode(node)
            if treeList.isEmpty {
                treeList = .defaultList()
            }
        }
        
        Task {
            await databaseService.save(tree: treeList)
        }
    }
}

extension TreeList where Value == DeeplinkTreeItemType {
    
    static func defaultList() -> TreeList {
        return TreeList([
            .folderNode()
        ])
    }
}

extension TreeNode where Value == DeeplinkTreeItemType {
    
    static func deeplinkNode() -> TreeNode {
        return TreeNode(
            .deeplink(
                data: .init(
                    name: "Deeplink",
                    schema: "shopback",
                    path: .empty
                )
            )
        )
    }
    
    static func folderNode() -> TreeNode {
        return TreeNode(
            .folder(name: "Deeplinks", id: UUID().uuidString)
        )
    }
}
