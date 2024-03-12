//
//  DeeplinkFileView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import SwiftUI

struct DeeplinkFileView: View {
    
    let title: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image("link")
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
                .clipped()
            
            Text(title)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color.white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#Preview {
    DeeplinkFileView(title: "Challenge home")
}
