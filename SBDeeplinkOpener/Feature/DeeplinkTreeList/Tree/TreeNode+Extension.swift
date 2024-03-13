//
//  TreeNode+Extension.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import Foundation

extension TreeNode {
    var optionalChildren: [TreeNode<Value>]? {
        children.isEmpty ? nil : children
    }
}
