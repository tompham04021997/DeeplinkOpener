//
//  InfoGroupView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import SwiftUI

struct InfoGroupView: View {
    
    let title: String
    @Binding var value: String
    
    var body: some View {
        
        HStack {
            Text(title)
            
            TextField("", text: $value)
        }
    }
}

#Preview {
    InfoGroupView(title: "Deeplink", value: .constant("Deeplink value"))
}
