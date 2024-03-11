//
//  SimulatorDataParser.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 11/03/2024.
//

import Foundation

final class SimulatorDataParser {}

extension SimulatorDataParser: SimulatorDataParserProtocol {
    
    func parsedSimulators(from input: String) -> [Simulator] {
        var simulators: [Simulator] = []
        let lines = input.components(separatedBy: .newlines)
        
        var currentIOSVersion: String?
        
        for line in lines {
            if let version = getIOSVersion(from: line) {
                currentIOSVersion = version
            }
            
            if let currentIOSVersion, let simulator = getSimulatorData(from: line, iOSVersion: currentIOSVersion) {
                simulators.append(simulator)
            }
        }
        
        print(simulators)
        
        return simulators
    }
}

extension SimulatorDataParser {
    
    private func getIOSVersion(from line: String) -> String? {
        let pattern = "-- iOS ([\\d\\.]+) --"
        do  {
            let regex = try NSRegularExpression(pattern: pattern)
            if let match = regex.firstMatch(in: line, range: NSRange(line.startIndex..., in: line)),
               let versionRange = Range(match.range(at: 1), in: line) {
                return String(line[versionRange])
            }
        } catch {
            print("Error: Invalid regular expression pattern with error: \(error)")
        }
        
        return nil
    }
    
    private func isIPhoneSimulator(line: String) -> Bool {
        return false
    }
    
    private func getSimulatorData(from line: String, iOSVersion: String) -> Simulator? {
        let pattern = #"iPhone ([^()]+) \(([^)]+)\) \(([^)]+)\)"#
        
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            if let match = regex.firstMatch(in: line, range: NSRange(line.startIndex..., in: line)) {
                let nameRange = Range(match.range(at: 1), in: line)!
                let uuidRange = Range(match.range(at: 2), in: line)!
                let stateRange = Range(match.range(at: 3), in: line)!
                
                let name = String(line[nameRange])
                let uuid = String(line[uuidRange])
                let state = String(line[stateRange])
                
                return Simulator(version: iOSVersion, name: "iPhone" + name, uuid: uuid, state: SimulatorState(rawValue: state) ?? .shutdown)
            }
        } catch {
            print("Error: Invalid regular expression pattern")
        }
        return nil
    }
}
