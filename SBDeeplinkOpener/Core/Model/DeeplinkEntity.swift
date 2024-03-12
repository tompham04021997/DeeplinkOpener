//
//  DeeplinkEntity.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import Foundation

struct DeeplinkEntity {
    
    let id: String
    let name: String
    let schema: String
    let path: String
    let params: [String: String]?
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
