//
//  DeeplinkOpenerProtocol.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 11/03/2024.
//

import Foundation

protocol DeeplinkOpenerProtocol {
    
    func openDeeplink(_ deeplink: String, on simulator: Simulator)
}
