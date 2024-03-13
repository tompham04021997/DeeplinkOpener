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
        
        guard let deeplinkURL = URL(string: deeplink) else {
            throw DeeplinkParserError.invalidateDeeplinkURL
        }
        
        guard let schema = deeplinkURL.scheme else {
            throw DeeplinkParserError.invalidateDeeplinkSchema
        }
        
        return schema
    }
}
