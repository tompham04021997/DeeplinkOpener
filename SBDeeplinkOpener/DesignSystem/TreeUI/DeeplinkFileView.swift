//
//  DeeplinkFileView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import SwiftUI

struct DeeplinkFileView: View {
    
    private var title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Image("link")
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
                .clipped()
            
            Text(title)
                .font(.system(size: 12, weight: .regular))
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#Preview {
    DeeplinkFileView(title: "Challenge home")
}
