//
//  TreeFolderView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import SwiftUI

struct TreeFolderView: View {
    
    private var title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Image("folder")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .clipped()
            
            Text(title)
                .font(.system(size: 16, weight: .regular))
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#Preview {
    TreeFolderView(title: "Folder name")
}
