//
//  DirectoryNameEditableView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 17/03/2024.
//

import SwiftUI

struct DirectoryNameEditableView: View {
    
    // MARK: - Data
    
    @State private var directoryName: String = ""
    
    // MARK: - Callbacks
    
    let submitTitle: String
    let onSubmit: (String) -> Void
    
    // MARK: - Initializers
    
    init(submitTitle: String, onRename: @escaping (String) -> Void) {
        self.submitTitle = submitTitle
        self.onSubmit = onRename
    }
    
    
    var body: some View {
        VStack(spacing: .dimensionSpace4) {
            TextField("Enter your expectation", text: $directoryName)
            Button(submitTitle) {
                onSubmit(directoryName)
            }
        }
        .frame(minWidth: 400)
        .padding(.all, .dimensionSpace4)
    }
}

#Preview {
    DirectoryNameEditableView(
        submitTitle: "Rename"
    ) { _ in
        
    }
}
