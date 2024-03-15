//
//  StorageServiceProtocol.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 13/03/2024.
//

import Foundation

protocol DeeplinkDataStorageServiceProtocol {
    
    func save(tree: TreeNode<DeeplinkTreeItemType>) async -> Bool
    
    func read() async -> TreeNode<DeeplinkTreeItemType>
}
