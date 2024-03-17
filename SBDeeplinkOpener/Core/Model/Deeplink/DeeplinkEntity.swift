//
//  DeeplinkEntity.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import Foundation

struct DeeplinkEntity {
    
    // MARK: - Properties

    let id: String
    let name: String
    let schema: String
    let path: String
    let params: [DeeplinkParamEntity]?
    
    init(id: String = UUID().uuidString, name: String, schema: String, path: String, params: [DeeplinkParamEntity]? = nil) {
        self.id = id
        self.name = name
        self.schema = schema
        self.path = path
        self.params = params
    }
}

extension DeeplinkEntity: Codable {
    private enum CodingKeys: String, CodingKey {
        case id, name, schema, path, params
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? container.decode(String.self, forKey: .id)) ?? ""
        name = (try? container.decode(String.self, forKey: .name)) ?? ""
        schema = (try? container.decode(String.self, forKey: .schema)) ?? ""
        path = (try? container.decode(String.self, forKey: .path)) ?? ""
        params = try? container.decodeIfPresent([DeeplinkParamEntity].self, forKey: .params)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(schema, forKey: .schema)
        try container.encode(path, forKey: .path)
        try container.encodeIfPresent(params, forKey: .params)
    }
}

extension DeeplinkEntity: Equatable {
    static func == (lhs: DeeplinkEntity, rhs: DeeplinkEntity) -> Bool {
        
        let lhsFilteredParams = (lhs.params?.filter { !$0.key.isEmpty }).or([])
        let rhsfilteredParams = (rhs.params?.filter { !$0.key.isEmpty }).or([])
        
        return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.path == rhs.path
        && lhs.schema == rhs.schema
        && lhsFilteredParams == rhsfilteredParams
    }
}
