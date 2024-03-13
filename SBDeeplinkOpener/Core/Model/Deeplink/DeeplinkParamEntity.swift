//
//  DeeplinkParamEntity.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 13/03/2024.
//

import Foundation

class DeeplinkParamEntity {
    
    let id = UUID()
    var key: String
    var value: String
    
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
    
    static func empty() -> DeeplinkParamEntity {
        DeeplinkParamEntity(key: .empty, value: .empty)
    }
}
