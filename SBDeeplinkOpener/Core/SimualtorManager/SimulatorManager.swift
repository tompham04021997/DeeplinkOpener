//
//  SimulatorManager.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 11/03/2024.
//

import Foundation

/// Represents a protocol for managing simulators

final class SimulatorManager {

    // MARK: - Dependencies

    private let simulatorDataParser: SimulatorDataParserProtocol
    
    // MARK: - Initializers

    init(simulatorDataParser: SimulatorDataParserProtocol = SimulatorDataParser()) {
        self.simulatorDataParser = simulatorDataParser
    }
}

// MARK: - SimulatorManagerProtocol

extension SimulatorManager: SimulatorManagerProtocol {
    
    func getAvailableSimulators() -> [Simulator] {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = ["xcrun", "simctl", "list", "devices"]
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        if let output = String(data: data, encoding: .utf8) {
            return simulatorDataParser.parsedSimulators(from: output)
        }
        
        return []
    }
}
