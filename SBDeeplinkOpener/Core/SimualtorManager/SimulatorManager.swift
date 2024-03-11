//
//  SimulatorManager.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 11/03/2024.
//

import Foundation

final class SimulatorManager {
    
    private let simulatorDataParser: SimulatorDataParserProtocol
    
    init(simulatorDataParser: SimulatorDataParserProtocol = SimulatorDataParser()) {
        self.simulatorDataParser = simulatorDataParser
    }
}

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
