//
//  AppDeeplinkOpener.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import Foundation
import AppKit

/// Represents a class for opening a deeplink on a simulator
final class AppDeeplinkOpener {
    
    // MARK: - Dependencies

    private let simulatorManager = SimulatorManager()
}

// MARK: - DeeplinkOpenerProtocol

extension AppDeeplinkOpener: DeeplinkOpenerProtocol {
    
    func openDeeplink(_ deeplink: String, on simulator: Simulator) {
        bootSimulatorIfNeeded(simulator)
        openDeeplink(deeplink, withSimulatorUUID: simulator.uuid)
    }
}

// MARK: - Privates

extension AppDeeplinkOpener {
    
    private func bootSimulatorIfNeeded(_ simulator: Simulator) {
        let bootTask = Process()
        bootTask.launchPath = "/usr/bin/env"
        bootTask.arguments = ["xcrun", "simctl", "boot", simulator.uuid]
        bootTask.launch()
        bootTask.waitUntilExit()
    }
    
    private func openDeeplink(_ deeplink: String, withSimulatorUUID uuid: String) {
        let script = """
                    xcrun simctl openurl \(uuid) \(deeplink)
                """
        
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", script]
        task.launch()
        task.waitUntilExit()
    }
}
