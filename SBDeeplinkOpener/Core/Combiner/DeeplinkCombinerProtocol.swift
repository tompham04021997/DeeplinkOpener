//
//  DeeplinkCombinerProtocol.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import Foundation

protocol DeeplinkCombinerProtocol {
    
    func combineToDeeplink(fromEntity entity: DeeplinkEntity) -> String
}
