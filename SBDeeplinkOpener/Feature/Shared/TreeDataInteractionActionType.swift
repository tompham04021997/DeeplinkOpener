//
//  TreeDataInteractionActionType.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 14/03/2024.
//

import Foundation

enum TreeDataInteractionActionType {
    case createFolder
    case createDeeplink
    case updateNodeValue(newValue: DeeplinkTreeItemType)
    case removeNode(node: TreeNode<DeeplinkTreeItemType>)
}