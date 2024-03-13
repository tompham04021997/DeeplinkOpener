//
//  DeeplinkEntity.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import Foundation

final class DeeplinkEntity: Codable {
    
    var id: String
    var name: String
    var schema: String
    var path: String
    var params: [DeeplinkParamEntity]?
    
    init(id: String, name: String, schema: String, path: String, params: [DeeplinkParamEntity]? = nil) {
        self.id = id
        self.name = name
        self.schema = schema
        self.path = path
        self.params = params
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, name, schema, path, params
    }
    
    required init(from decoder: Decoder) throws {
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
