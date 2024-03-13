//
//  TreeFolderView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import SwiftUI

struct TreeFolderView: View {
    
    @State private var title: String
    
    var onFolderNameChanged: (String) -> Void
    
    init(title: String, onFolderNameChanged: @escaping (String) -> Void) {
        self._title = State(wrappedValue: title)
        self.onFolderNameChanged = onFolderNameChanged
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Image("folder")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .clipped()
            
            EditableText(text: $title)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(Color.white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .onChange(of: title) { oldValue, newValue in
            onFolderNameChanged(newValue)
        }
    }
}

#Preview {
    TreeFolderView(title: "Folder name") { _ in
        
    }
}
