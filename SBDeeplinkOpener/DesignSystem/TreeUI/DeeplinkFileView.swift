//
//  DeeplinkFileView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import SwiftUI

struct DeeplinkFileView: View {
    
    @State private var title: String
    
    var onFileNameChanged: (String) -> Void
    
    init(title: String, onFileNameChanged: @escaping (String) -> Void) {
        self._title = State(wrappedValue: title)
        self.onFileNameChanged = onFileNameChanged
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Image("link")
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
                .clipped()
            
            EditableText(text: $title)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color.white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .onChange(of: title) { oldValue, newValue in
            onFileNameChanged(newValue)
        }
    }
}

#Preview {
    DeeplinkFileView(title: "Challenge home") { _ in
        
    }
}
