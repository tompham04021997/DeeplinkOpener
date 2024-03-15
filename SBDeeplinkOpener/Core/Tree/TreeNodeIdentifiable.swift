//
//  TreeNodeIdentifiable.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 15/03/2024.
//

import Foundation

/// A type that can be identified by a unique identifier.
public protocol TreeNodeIdentifiable {

    /// A type representing the unique identifier of the conforming type.
    /// 
    /// The identifier should be unique within the same tree.
    var id: String { get }
}
