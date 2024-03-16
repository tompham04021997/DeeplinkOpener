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
    
    var parentID: String?
    
    /// The unique identifier of the node.
    var nodeID: String {
        return value.id
    }
    
    // MARK: - Initializers
    
    init(value: Value, children: [TreeNode<Value>] = [], parentID: String? = nil) {
        self.value = value
        self.children = children
        self.parentID = parentID
    }

    private enum CodingKeys: String, CodingKey {
        case value, children, parentID
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(Value.self, forKey: .value)
        self.children = try container.decode([TreeNode<Value>].self, forKey: .children)
        self.parentID = try container.decodeIfPresent(String.self, forKey: .parentID)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.value, forKey: .value)
        try container.encode(self.children, forKey: .children)
        try container.encode(self.parentID, forKey: .parentID)
    }
}

/// MARK: - Publics

extension TreeNode {
    
    /// Indicates whether the node is a leaf node.
    var isSingle: Bool {
        return children.isEmpty
    }
    
    /// Indicates whether the node has children.
    var hasFamily: Bool {
        return !children.isEmpty
    }
    
    /// Adopted optional children for supporting List View.
    var optionalChildren: [TreeNode<Value>]? {
        guard children.isEmpty else {
            return children
        }
        
        return nil
    }
    
    /// Adds a child to the node.
    /// 
    /// - Parameter child: The child node to be added.
    /// 
    /// - Returns: The current node.
    @discardableResult
    func add(child: TreeNode<Value>) -> Self {
        children.append(child)
        child.parentID = nodeID
        return self
    }
    
    /// Adds a child to a specific node.
    /// 
    /// - Parameters:
    ///    - child: The child node to be added.
    ///    - node: The node to which the child will be added.
    ///
    /// - Returns: The current node.
    @discardableResult
    func add(child: TreeNode<Value>, toNode node: TreeNode<Value>) -> Self {
        node.add(child: child)
        return self
    }
    
    /// Adds a child to a specific nodeID.
    /// 
    /// - Parameters:
    ///    - child: The child node to be added.
    ///    - nodeID: The unique identifier of the node to which the child will be added.
    ///
    /// - Returns: The current node.
    @discardableResult
    func add(child: TreeNode<Value>, toNodeWithID nodeID: String) -> Self {
        guard let node = searchByID(nodeID) else {
            return self
        }
        
        node.add(child: child)
        return self
    }
    
    /// Removes a child from the node.
    /// 
    /// - Parameter child: The child node to be removed.
    /// 
    /// - Returns: The current node.
    @discardableResult
    func remove(child: TreeNode<Value>) -> Self {
        if let index = children.firstIndex(where: { $0.nodeID == child.nodeID }) {
            children.remove(at: index)
        }
        
        children.forEach { $0.remove(child: child) }
        return self
    }
    
    /// Replace a child with a new node.
    /// 
    /// - Parameter child: The child node to be replaced.
    /// 
    /// - Returns: The current node.
    @discardableResult
    func replace(child: TreeNode<Value>) -> Self {
        if let index = children.firstIndex(where: { $0.nodeID == child.nodeID }) {
            children[index] = child
            return self
        }
        
        children.forEach { $0.replace(child: child) }
        return self
    }
    
    /// Searches for a node by its unique identifier.
    /// 
    /// - Parameter id: The unique identifier of the node to be searched.
    /// 
    /// - Returns: The node with the given unique identifier, if it exists.
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
    
    /// Updates the value of the node.
    /// 
    /// - Parameter newValue: The new value of the node.
    func updateValue(_ newValue: Value) {
        self.value = newValue
    }
    
    /// Updates the value of a specific node.
    /// 
    /// - Parameters:
    ///   - newValue: The new value of the node.
    ///   - nodeID: The unique identifier of the node to be updated.
    ///
    /// - Returns: The current node.
    @discardableResult
    func updateValue(_ newValue: Value, forNodeID id: String) -> Self {
        guard let node = searchByID(id) else {
            return self
        }
        
        node.value = newValue
        return self
    }
    
    /// Get the parent of a specific node.
    /// 
    /// - Parameters:
    ///    - childID: The unique identifier of the child node.
    /// 
    /// - Returns: The parent node of the child node, if it exists.
    func getParent(ofChildWithID childID: String) -> TreeNode<Value>? {
        guard let child = searchByID(childID),
              let parentID = child.parentID else { return nil }
        return searchByID(parentID)
    }
}
