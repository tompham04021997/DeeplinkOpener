//
//  EditableText.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 13/03/2024.
//

import SwiftUI

struct EditableText: View {
    @Binding var text: String
    @State private var temporaryText: String
    @FocusState private var isFocused: Bool
    
    // Initialize with a binding to the text
    init(text: Binding<String>) {
        self._text = text
        self.temporaryText = text.wrappedValue
    }
    
    var body: some View {
        ZStack {
            textField
            tapInterceptor
        }
    }
    
    // The TextField that is shown when the view is focused
    private var textField: some View {
        TextField("", text: $temporaryText, onCommit: { text = temporaryText })
            .focused($isFocused, equals: true)
            .onExitCommand { 
                temporaryText = text
                isFocused = false 
            }
    }
    
    // The view that intercepts single taps when the TextField is not focused
    private var tapInterceptor: some View {
        Group {
            if !isFocused {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture(count: 2) {
                        isFocused = true
                    }
            }
        }
    }
}

#Preview {
    @State var text = "OK"
    
    return EditableText(
        text: $text
    )
}
