//
//  TreeNode+DeeplinkItemType.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 16/03/2024.
//

import Foundation

extension TreeNode where Value == DeeplinkTreeItemType {
    
    static func root() -> TreeNode<DeeplinkTreeItemType> {
        return .init(
            value: .folder(
                name: "Root",
                id: UUID().uuidString
            ),
            children: [
                .init(
                    value: .folder(
                        name: "Deeplink",
                        id: UUID().uuidString
                    )
                )
            ]
        )
    }
    
    static func folder() -> TreeNode<DeeplinkTreeItemType> {
        return .init(
            value: .folder(
                name: "Folder",
                id: UUID().uuidString
            )
        )
    }
    
    static func deeplinkFile() -> TreeNode<DeeplinkTreeItemType> {
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
