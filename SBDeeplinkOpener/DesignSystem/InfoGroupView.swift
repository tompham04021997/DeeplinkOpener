//
//  InfoGroupView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import SwiftUI

struct InfoGroupView: View {
    
    let title: String
    @State var value: String
    var onValueChanged: (String) -> Void
    
    init(
        title: String,
        value: String,
        onValueChanged: @escaping (String) -> Void
    ) {
        self.title = title
        self._value = State(
            wrappedValue: value
        )
        self.onValueChanged = onValueChanged
    }
    
    var body: some View {
        HStack {
            Text(title)
            
            TextField("", text: $value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.white))
        }
        .padding(.vertical, .dimensionSpace2)
        .onChange(of: value) { oldValue, newValue in
            onValueChanged(newValue)
        }
    }
}

#Preview {
    InfoGroupView(title: "Deeplink", value: "Deeplink value", onValueChanged: { _ in })
}
