//
//  LoadingView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 17/03/2024.
//

import SwiftUI
import Lottie

struct LoadingView: View {
    var body: some View {
        LottieView(name: "loading_animation.json")
            .frame(width: 128, height: 128)
    }
}

#Preview {
    LoadingView()
        .frame(width: 400, height: 400)
}
