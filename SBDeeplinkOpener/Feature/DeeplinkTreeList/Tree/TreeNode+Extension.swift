//
//  TreeNode+Extension.swift
//  SBDeeplinkOpener
//

import Foundation

extension TreeNode {
    var optionalChildren: [TreeNode<Value>]? {
        children.isEmpty ? nil : children
    }
}
