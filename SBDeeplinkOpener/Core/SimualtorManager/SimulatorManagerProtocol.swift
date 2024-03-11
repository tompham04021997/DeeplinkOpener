//
//  SimulatorManagerProtocol.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 11/03/2024.
//

import Foundation

/// Represents a protocol for managing simulators
protocol SimulatorManagerProtocol {
    
    /// Get all available simulators
    /// 
    /// - Returns: An array of available simulators
    func getAvailableSimulators() -> [Simulator]
}
