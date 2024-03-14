//
//  DeeplinkParser.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 13/03/2024.
//

import Foundation

final class DeeplinkParser {
    
}

extension DeeplinkParser: DeeplinkParserProtocol {
    
    func getSchema(fromDeeplink deeplink: String) throws -> String {
        
        guard let deeplinkURL = URL(string: deeplink),
                let components = URLComponents(url: deeplinkURL, resolvingAgainstBaseURL: true)
        else {
            throw DeeplinkParserError.invalidateDeeplinkURL
        }
        
        guard let schema = components.scheme else {
            throw DeeplinkParserError.invalidateDeeplinkSchema
        }
        
        return schema
    }
    
    func getPath(fromDeeplink deeplink: String) throws -> String {
        guard let deeplinkURL = URL(string: deeplink),
              let components = URLComponents(url: deeplinkURL, resolvingAgainstBaseURL: true) else {
            throw DeeplinkParserError.invalidateDeeplinkURL
        }
        
        var fullPath = ""
        if let host = components.host {
            fullPath += host
        }
        
        fullPath += components.path
        
        return fullPath
    }
    func getParams(fromDeeplink deeplink: String) throws -> [DeeplinkParamEntity] {
        guard let deeplinkURL = URL(string: deeplink),
              let components = URLComponents(url: deeplinkURL, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else {
            throw DeeplinkParserError.invalidateDeeplinkURL
        }
        
        return queryItems.map { DeeplinkParamEntity(key: $0.name, value: $0.value.orEmpty) }
    }
}
