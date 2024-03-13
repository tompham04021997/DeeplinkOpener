//
//  DeeplinkParamEntity.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 13/03/2024.
//

import Foundation

class DeeplinkParamEntity: Codable {
    
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

    enum CodingKeys: CodingKey {
        case id
        case key
        case value
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.key = try container.decode(String.self, forKey: .key)
        self.value = try container.decode(String.self, forKey: .value)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.key, forKey: .key)
        try container.encode(self.value, forKey: .value)
    }
}
