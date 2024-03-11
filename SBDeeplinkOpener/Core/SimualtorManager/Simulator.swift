//
//  Simulator.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 11/03/2024.
//

import Foundation

/// Represents a simulator
struct Simulator {
    
    /// The version of the simulator
    ///
    /// Example: "13.3"
    let version: String

    /// The name of the simulator
    /// 
    /// Example: "iPhone 11 (UUID) (Shutdown)" 
    let name: String

    /// The UUID of the simulator
    let uuid: String

    /// The state of the simulator
    let state: SimulatorState
}

// MARK: - CustomStringConvertible

extension Simulator: CustomStringConvertible {
    
    var description: String {
        return """
            iPhone: \(name)
            "version": \(version)
            "UUID": \(uuid)
            "State": "\(state.rawValue)"
        """
    }
}
