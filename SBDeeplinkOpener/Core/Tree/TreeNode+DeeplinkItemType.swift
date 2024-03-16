//
//  TreeNode+DeeplinkItemType.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 16/03/2024.
//

import Foundation

extension TreeNode where Value == DirectoryType {
    
    /// Create a default tree for the app.
    /// 
    /// - Returns: A tree with the root node and a folder node.
    static func root() -> TreeNode<DirectoryType> {
        
        let rootID = UUID().uuidString
        return .init(
            value: .folder(
                name: "Root",
                id: rootID
            ),
            children: [
                .init(
                    value: .folder(
                        name: "Deeplink",
                        id: UUID().uuidString
                    )
                )
            ],
            parentID: rootID
        )
    }
    
    /// Create a default folder with name `Folder` node.
    /// 
    /// - Returns: A folder node.
    static func folder() -> TreeNode<DirectoryType> {
        return .init(
            value: .folder(
                name: "Folder",
                id: UUID().uuidString
            )
        )
    }
    
    /// Create a default deeplink with schema is `Shopback` node.
    /// 
    /// - Returns: A deeplink node.
    static func deeplinkFile() -> TreeNode<DirectoryType> {
        return .init(
            value: .deeplink(
                data: .init(
                    name: "Deeplink",
                    schema: "shopback",
                    path: .empty
                )
            )
        )
    }
}
