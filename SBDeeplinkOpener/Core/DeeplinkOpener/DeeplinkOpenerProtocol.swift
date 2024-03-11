//
//  DeeplinkOpenerProtocol.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 11/03/2024.
//

import Foundation

/// Represents a protocol for opening a deeplink on a simulator
protocol DeeplinkOpenerProtocol {
    
    /// Open a deeplink on a simulator
    /// 
    /// - Parameters:
    ///  - deeplink: The deeplink to open
    /// - simulator: The simulator to open the deeplink on
    /// 
    /// Note: The deeplink should be a valid URL
    func openDeeplink(_ deeplink: String, on simulator: Simulator)
}
