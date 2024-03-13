//
//  AppDependencyContainer.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import SwiftUI

struct DeeplinkCombinerKey: EnvironmentKey {
    static let defaultValue: DeeplinkCombinerProtocol = DeeplinkCombiner()
}

extension EnvironmentValues {
    
    var deeplinkCombiner: DeeplinkCombinerProtocol {
        get { self[DeeplinkCombinerKey.self] }
        set { self[DeeplinkCombinerKey.self] = newValue }
    }
}
