//
//  TreeDataManager.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 14/03/2024.
//

import SwiftUI
import Factory

final class TreeDataManager: ObservableObject {

    // MARK: - Publishers
    
    @Published var treeList: TreeNode<DeeplinkTreeItemType> = .root()
    @Published var selectedDeeplink: TreeNode<DeeplinkTreeItemType>?
    @Published var selectedNode: TreeNode<DeeplinkTreeItemType>?
    
    // MARK: - Dependencies
    
    @LazyInjected(\.dataStorageService) var dataStorageService
    
    // MARK: - Initializers
    
    init() {
        Task {
            let data = await dataStorageService.read()
            await MainActor.run {
                treeList = data
            }
        }
    }
    
    func updateDeeplinkData(_ value: DeeplinkEntity) async {
        guard let nodeID = selectedDeeplink?.nodeID else { return }
        let temperatureTreeList = treeList
        temperatureTreeList.updateValue(.deeplink(data: value), forNodeID: nodeID)
        await MainActor.run {
            treeList = temperatureTreeList
        }
        _ = await dataStorageService.save(tree: treeList)
    }
    
    func performAction(_ action: TreeDataInteractionActionType, on node: TreeNode<DeeplinkTreeItemType>) async {
        
        let temperatureTreeList = treeList
        switch action {
        case .createFolder:
            temperatureTreeList.add(child: .folder(), toNodeWithID: node.nodeID)

        case .createDeeplink:
            temperatureTreeList.add(child: .deeplinkFile(), toNodeWithID: node.nodeID)
            
        case .updateNodeValue(let newValue):
            node.value = newValue
            temperatureTreeList.replace(child: node)
            
        case .removeNode(let node):
            if treeList.hasFamily {
                temperatureTreeList.remove(child: node)
            }
        }
        
        await MainActor.run {
            treeList = temperatureTreeList
        }
        
        Task {
            await dataStorageService.save(tree: temperatureTreeList)
        }
    }
}
