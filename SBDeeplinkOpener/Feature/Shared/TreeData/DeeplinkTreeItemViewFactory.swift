//
//  DeeplinkTreeItemViewFactory.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 14/03/2024.
//

import SwiftUI

final class DeeplinkTreeItemViewFactory {}

// MARK: - DeeplinkTreeItemViewFactoryProtocol

extension DeeplinkTreeItemViewFactory: DeeplinkTreeItemViewFactoryProtocol {
    
    @ViewBuilder
    func createView(
        for node: TreeNode<DirectoryType>,
        selection: TreeNode<DirectoryType>?,
        onSelection: @escaping VoidCallBack,
        onPerformAction: @escaping (TreeDataInteractionActionType) -> Void
    ) -> some View {
        DirectoryWrapperView(
            node,
            selection: selection,
            onSelection: onSelection,
            onPerformAction: onPerformAction
        ) {
            switch node.value {
            case .folder(let name, _):
                TreeFolderView(
                    title: name
                )
            case .deeplink(let data):
                DeeplinkFileView(
                    title: data.name
                )
            }
        }
    }
}
