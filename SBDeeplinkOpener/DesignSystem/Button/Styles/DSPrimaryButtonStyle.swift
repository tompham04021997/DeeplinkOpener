//
//  DSPrimaryButtonStyle.swift
//  ProFamilySharing
//
//  Created by Tuan Pham on 16/12/2023.
//

import SwiftUI

struct DSPrimaryButtonStyle: DSButtonStyle {
    
    let defaultColor: Color
    
    let selectingColor: Color
    
    let strokeColor: Color
    
    let foregroundColor: Color
    
    init(
        defaultColor: Color = .red80,
        selectingColor: Color = .red100,
        strokeColor: Color = .clear,
        foregroundColor: Color = .grey20
    ) {
        self.defaultColor = defaultColor
        self.selectingColor = selectingColor
        self.strokeColor = strokeColor
        self.foregroundColor = foregroundColor
    }
}
