//
//  DeeplinkTreeItemViewFactoryProtocol.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 14/03/2024.
//

import SwiftUI

protocol DeeplinkTreeItemViewFactoryProtocol {
    
    associatedtype ContentView: View
    @ViewBuilder func createView(
        for node: TreeNode<DirectoryType>,
        selection: TreeNode<DirectoryType>?,
        onSelection: @escaping VoidCallBack,
        onPerformAction: @escaping (TreeDataInteractionActionType) -> Void
    ) -> ContentView
}
