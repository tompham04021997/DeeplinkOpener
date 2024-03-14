//
//  DeeplinkParserProtocol.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 13/03/2024.
//

import Foundation

protocol DeeplinkParserProtocol {
    func getSchema(fromDeeplink deeplink: String) throws -> String
    func getPath(fromDeeplink deeplink: String) throws -> String
    func getParams(fromDeeplink deeplink: String) throws -> [DeeplinkParamEntity]
}
