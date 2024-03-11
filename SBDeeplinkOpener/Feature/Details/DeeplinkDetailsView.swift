//
//  DeeplinkDetailsView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import SwiftUI

struct DeeplinkDetailsView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack {
                
                InfoGroupView(title: "Deeplink", value: .constant("shopback://challenge?code=T4498609"))
                Spacer()
                
                Button {
                    AppDeeplinkOpener().openDeeplink("shopback://challenge?code=T4498609")
                } label: {
                    HStack {
                        Spacer()
                        Text("Open")
                        Spacer()
                    }
                }
                .buttonStyle(AppPrimaryButtonStyle())
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 32)
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

#Preview {
    DeeplinkDetailsView()
        .frame(minWidth: 200, minHeight: 400)
}
