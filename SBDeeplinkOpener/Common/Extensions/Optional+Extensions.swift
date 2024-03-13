//
//  Optional+Extensions.swift
//  ProFamilySharing
//
//  Created by Tuan Pham on 31/12/2023.
//

import Foundation

extension Optional {
    func or(_ other: Wrapped) -> Wrapped {
        return self ?? other
    }
}
extension Optional where Wrapped == String {
    var orEmpty: String {
        return or("")
    }
}
