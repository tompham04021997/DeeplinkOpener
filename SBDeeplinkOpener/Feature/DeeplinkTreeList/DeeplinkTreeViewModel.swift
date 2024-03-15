//
//  DeeplinkTreeViewModel.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 13/03/2024.
//

import Foundation

enum DeeplinkTreeDateState {
    case loading
    case loaded(tree: TreeNode<DeeplinkTreeItemType>)
}

final class DeeplinkTreeViewModel: ObservableObject {}
