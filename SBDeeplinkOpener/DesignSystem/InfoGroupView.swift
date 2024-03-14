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
    
    init(
        title: String,
        value: Binding<String>
    ) {
        self.title = title
        self._value = value
    }
    
    var body: some View {
        HStack {
            Text(title)
            
            TextField("", text: $value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.white))
        }
        .padding(.vertical, .dimensionSpace2)
    }
}

#Preview {
    InfoGroupView(title: "Deeplink", value: .constant("Value"))
}
