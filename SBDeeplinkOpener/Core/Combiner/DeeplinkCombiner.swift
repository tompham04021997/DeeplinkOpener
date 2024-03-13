//
//  DeeplinkCombiner.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import Foundation

final class DeeplinkCombiner {}

extension DeeplinkCombiner: DeeplinkCombinerProtocol {
    
    func combineToDeeplink(fromEntity entity: DeeplinkEntity) -> String {
        var modifiedDeeplink = "\(entity.schema)://\(entity.path)"
        if let params = entity.params {
            modifiedDeeplink += "?\(combinedToDeeplinkForParams(params))"
        }
        return modifiedDeeplink
    }
}

extension DeeplinkCombiner {
    
    private func combinedToDeeplinkForParams(_ params: [DeeplinkParamEntity]) -> String {
        var combinedParams: [String] = []
        params.filter{ !$0.key.isEmpty }
            .forEach { paramInfo in
            combinedParams += ["\(paramInfo.key)=\(paramInfo.value)"]
        }
        
        return combinedParams.joined(separator: "&")
        
    }
}
