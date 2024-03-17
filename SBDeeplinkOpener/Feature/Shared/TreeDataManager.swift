//
//  TreeDataManager.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 14/03/2024.
//

import SwiftUI
import Factory
import Combine

final class TreeDataManager: ObservableObject {

    // MARK: - Publishers
    
    @Published var treeList: TreeNode<DirectoryType> = .root()
    @Published var selectedDeeplink: TreeNode<DirectoryType>?
    @Published var selectedNode: TreeNode<DirectoryType>?
    
    // MARK: - Dependencies
    
    
    private var cancellables = Set<AnyCancellable>()
    @LazyInjected(\.dataStorageService) var dataStorageService
    
    // MARK: - Initializers
    
    init() {
        Task {
            let data = await dataStorageService.read()
            await MainActor.run {
                treeList = data
            }
        }
        
        $selectedNode
            .filter { node -> Bool in
                switch node?.value {
                case .deeplink:
                    return true
                    
                default:
                    return false
                }
            }
            .assign(to: \.selectedDeeplink, on: self)
            .store(in: &cancellables)
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
    
    func performAction(_ action: TreeDataInteractionActionType, on node: TreeNode<DirectoryType>) async {
        
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
