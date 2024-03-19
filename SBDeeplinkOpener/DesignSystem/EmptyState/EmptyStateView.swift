//
//  EmptyStateView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import SwiftUI

struct EmptyStateView: View {
    
    let title: String?
    let message: String?
    
    init(title: String? = nil, message: String? = nil) {
        self.title = title
        self.message = message
    }
    
    var body: some View {
        VStack {
            Spacer()
            TitleView(title: title)
            MessageView(message: message)
            Spacer()
        }
        .padding(.horizontal, 32)
    }
}

extension EmptyStateView {
    
    struct TitleView: View {
        
        let title: String?
        
        var body: some View {
            if let title {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                    Spacer()
                    Text(title)
                        .font(.largeTitle)
                    Spacer()
                })
            }
        }
    }
    
    struct MessageView: View {
        
        let message: String?
        var body: some View {
            if let message {
                HStack(alignment: .center, content: {
                    Spacer()
                    Text(message)
                        .font(.caption)
                    Spacer()
                })
            }
        }
    }
}

#Preview {
    EmptyStateView(
        title: "Title",
        message: "Message"
    )
}
