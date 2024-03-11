//
//  Simulator.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 11/03/2024.
//

import Foundation

struct Simulator {
    let version: String
    let name: String
    let uuid: String
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
