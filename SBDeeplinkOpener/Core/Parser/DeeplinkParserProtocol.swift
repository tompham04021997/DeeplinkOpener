//
//  DeeplinkParserProtocol.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 13/03/2024.
//

import Foundation

protocol DeeplinkParserProtocol {
    func getSchema(fromDeeplink deeplink: String) throws -> String
}
