//
//  DeeplinkEntity.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import Foundation

final class DeeplinkEntity {
    
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
}


enum DeeplinkParserError: Error {
    case invalidateDeeplinkURL
    case invalidateDeeplinkSchema
}

protocol DeeplinkParserProtocol {
    func getSchema(fromDeeplink deeplink: String) throws -> String
}

final class DeeplinkParser {
    
}

extension DeeplinkParser: DeeplinkParserProtocol {
    
    func getSchema(fromDeeplink deeplink: String) throws -> String {
        
        guard let deeplinkURL = URL(string: deeplink) else {
            throw DeeplinkParserError.invalidateDeeplinkURL
        }
        
        guard let schema = deeplinkURL.scheme else {
            throw DeeplinkParserError.invalidateDeeplinkSchema
        }
        
        return schema
    }
}
