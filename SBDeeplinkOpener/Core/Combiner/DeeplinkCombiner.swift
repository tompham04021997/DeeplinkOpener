//
//  DeeplinkCombiner.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import Foundation

final class DeeplinkCombiner {
    
}

extension DeeplinkCombiner: DeeplinkCombinerProtocol {
    
    func combineToDeeplink(fromEntity entity: DeeplinkEntity) -> String {
        var modifiedDeeplink = "\(entity.schema)://\(entity.path)"
        if let params = entity.params {
            var combinedParams: [String] = []
            params.forEach { key, value in
                combinedParams += ["\(key)=\(value)"]
            }
            
            modifiedDeeplink += "?\(combinedParams.joined(separator: "&"))"
        }
        return modifiedDeeplink
    }
}
