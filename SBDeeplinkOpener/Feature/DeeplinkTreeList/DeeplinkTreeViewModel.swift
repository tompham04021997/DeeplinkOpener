//
//  DeeplinkTreeViewModel.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 13/03/2024.
//

import Foundation

enum DeeplinkTreeDateState {
    case loading
    case loaded(tree: TreeList<DeeplinkTreeItemType>)
    
    func getTree() -> TreeList<DeeplinkTreeItemType>? {
        switch self {
        case .loaded(let tree):
            return tree
            
        default:
            return nil
        }
    }
}

final class DeeplinkTreeViewModel: ObservableObject {
    
    @Published var dataState: DeeplinkTreeDateState = .loading
    private let dataStorageService = LocalDataStorageService()
    
    func fetch() async {
        let tree = await dataStorageService.read()
        await MainActor.run {
            dataState = .loaded(tree: tree)
        }
    }
    
    func updateNode(node: TreeNode<DeeplinkTreeItemType>, action: DeeplinkTreeActionType) {
        
        
        guard var tree = dataState.getTree() else {
            return
        }
        var editableNode = node
        switch action {
        case .createDeeplink, .createFolder:
            if let newNode = createNewNode(for: action) {
                tree.addChill(newNode, toNode: &editableNode)
            }
            
        case .updateNodeValue(let newValue):
            editableNode.value = newValue
            tree.updateNode(editableNode)
        }
        dataState = .loaded(tree: tree)
    }
    
    private func createNewNode(for action: DeeplinkTreeActionType) -> TreeNode<DeeplinkTreeItemType>? {
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
            
        case .updateNodeValue:
            return nil
        }
    }
}
