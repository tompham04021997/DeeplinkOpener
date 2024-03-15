//
//  Tree.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 15/03/2024.
//

import Foundation

/// Represents a tree data structure.
/// 
/// A tree is a hierarchical data structure that consists of nodes connected by edges.
class TreeNode<Value: ValueRequiredTypes>: Codable {
    
    /// The value of the node.
    /// 
    /// The value can be any type that conforms to `ValueRequiredTypes`.
    var value: Value
    
    /// The children of the node.
    /// 
    /// The children are the nodes that are connected to the current node.
    var children: [TreeNode<Value>]
    
    /// The unique identifier of the node.
    var nodeID: String {
        return value.id
    }
    
    // M
    init(value: Value, children: [TreeNode<Value>] = []) {
        self.value = value
        self.children = children
    }

    private enum CodingKeys: String, CodingKey {
        case value, children
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(Value.self, forKey: .value)
        self.children = try container.decode([TreeNode<Value>].self, forKey: .children)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.value, forKey: .value)
        try container.encode(self.children, forKey: .children)
    }
}

/// MARK: - Publics

extension TreeNode {
    
    var isSingle: Bool {
        return children.isEmpty
    }
    
    var hasFamily: Bool {
        return !children.isEmpty
    }
    
    var optionalChildren: [TreeNode<Value>]? {
        guard children.isEmpty else {
            return children
        }
        
        return nil
    }
    
    @discardableResult
    func add(child: TreeNode<Value>) -> Self {
        children.append(child)
        return self
    }
    
    @discardableResult
    func add(child: TreeNode<Value>, toNode node: TreeNode<Value>) -> Self {
        node.add(child: child)
        return self
    }
    
    @discardableResult
    func add(child: TreeNode<Value>, toNodeWithID nodeID: String) -> Self {
        guard let node = searchByID(nodeID) else {
            return self
        }
        
        node.add(child: child)
        return self
    }
    
    @discardableResult
    func remove(child: TreeNode<Value>) -> Self {
        if let index = children.firstIndex(where: { $0.nodeID == child.nodeID }) {
            children.remove(at: index)
        }
        
        children.forEach { $0.remove(child: child) }
        return self
    }
    
    @discardableResult
    func replace(child: TreeNode<Value>) -> Self {
        if let index = children.firstIndex(where: { $0.nodeID == child.nodeID }) {
            children[index] = child
            return self
        }
        
        children.forEach { $0.replace(child: child) }
        return self
    }
    
    func searchByID(_ id: String) -> TreeNode<Value>? {
        if id == self.nodeID {
            return self
        }
        
        for child in children {
            if let found = child.searchByID(id) {
                return found
            }
        }
        
        return nil
    }
    
    func updateValue(_ newValue: Value) {
        self.value = newValue
    }
    
    @discardableResult
    func updateValue(_ newValue: Value, forNodeID: String) -> Self {
        guard let node = searchByID(nodeID) else {
            return self
        }
        
        node.value = newValue
        return self
    }
}
