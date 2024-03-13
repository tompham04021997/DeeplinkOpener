//
//  DeeplinkTreeItemType.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 13/03/2024.
//

import Foundation

enum DeeplinkTreeItemType {
    case folder(name: String, id: String)
    case deeplink(data: DeeplinkEntity)
}

extension DeeplinkTreeItemType: Identifiable {
    var id: String {
        switch self {
        case .folder(_ , let id):
            return id
            
        case .deeplink(let data):
            return data.id
        }
    }
}

extension DeeplinkTreeItemType: Equatable {
    static func == (lhs: DeeplinkTreeItemType, rhs: DeeplinkTreeItemType) -> Bool {
        return lhs.id == rhs.id
    }
}

extension DeeplinkTreeItemType: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


extension DeeplinkTreeItemType: Codable {

    enum CodingKeys: String, CodingKey {
        case type
        case name
        case id
        case data
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case "folder":
            let name = try container.decode(String.self, forKey: .name)
            let id = try container.decode(String.self, forKey: .id)
            self = .folder(name: name, id: id)
        case "deeplink":
            let data = try container.decode(DeeplinkEntity.self, forKey: .data)
            self = .deeplink(data: data)
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Invalid type")
        }
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .folder(let name, let id):
            try container.encode("folder", forKey: .type)
            try container.encode(name, forKey: .name)
            try container.encode(id, forKey: .id)
        case .deeplink(let data):
            try container.encode("deeplink", forKey: .type)
            try container.encode(data, forKey: .data)
        }
    }
}
