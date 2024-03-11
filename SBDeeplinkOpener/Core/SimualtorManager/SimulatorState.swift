//
//  SimulatorState.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 11/03/2024.
//

import Foundation

/// Represents a state of a simulator

enum SimulatorState: String {

    /// The simulator is shutdown
    case shutdown = "Shutdown"

    /// The simulator is booted
    case booted = "Booted"
}
