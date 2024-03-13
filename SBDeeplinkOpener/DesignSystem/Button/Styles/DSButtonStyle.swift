//
//  DSButtonStyle.swift
//  ProFamilySharing
//
//  Created by Tuan Pham on 16/12/2023.
//

import SwiftUI

/// A common button style protocol for ProFamilySharing app.
///
/// - Note: Cofirm this protocol to create a new button style.
protocol DSButtonStyle: ButtonStyle {
    
    /// The background color of the button.
    var defaultColor: Color { get }
    
    var selectingColor: Color { get }
    
    var strokeColor: Color { get }
    
    var foregroundColor: Color { get }
}

// MARK: - ButtonStyle Extensions

extension DSButtonStyle {
    
    @ViewBuilder func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(makeBackgroundColor(configuration: configuration))
            .foregroundStyle(makeForegroundColor())
            .cornerRadius(.dimensionSpace3)
            .clipShape(RoundedRectangle(cornerRadius: .dimensionSpace3))
            .overlay(content: {
                RoundedRectangle(cornerRadius: .dimensionSpace3)
                    .strokeBorder(strokeColor, style: .init(lineWidth: 1))
                    .background(Color.clear)
            })
            .scaleEffect(estimatedScaleEffectValue(configuration: configuration))
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
    
    private func estimatedScaleEffectValue(configuration: Configuration) -> CGFloat {
        guard configuration.isPressed else {
            return 1.0
        }
        
        return 1.1
    }
    
    private func makeBackgroundColor(configuration: Configuration) -> some View {
        configuration.isPressed ? selectingColor : defaultColor
    }
    
    private func makeForegroundColor() -> some ShapeStyle {
        return foregroundColor
    }
}
