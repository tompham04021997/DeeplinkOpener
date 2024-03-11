//
//  AppPrimaryButtonStyle.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import SwiftUI

struct AppPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(Color.green)
                .foregroundStyle(.white)
                .clipShape(Capsule())
        }
}

#Preview {
    Button {
        
    } label: {
        HStack {
            Spacer()
            Text("Open")
            Spacer()
        }
    }
    .buttonStyle(AppPrimaryButtonStyle())
}
