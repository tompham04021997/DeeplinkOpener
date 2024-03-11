//
//  DeeplinkListView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import SwiftUI

struct DeeplinkListView: View {
    
    var deeplinkItems = [
        DeeplinkEntity(
            id: "1",
            deeplink: "shopback://challenge?code=SBOC_REJECTED_CASHBACK_06_03_2024",
            params: nil
        ),
        DeeplinkEntity(
            id: "2",
            deeplink: "shopback://challenge?code=SBOC_REJECTED_CASHBACK_06_03_2025",
            params: nil
        )
    ]
    
    var deeplinkParser = DeeplinkParser()
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(deeplinkItems, id: \.id) { item in
                        DeeplinkItemView(isSelected: .constant(false), viewModel: DeeplinkItemViewModel(entity: item))
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 16)
                .frame(width: proxy.size.width)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

#Preview {
    DeeplinkListView()
        .frame(width: 250)
}
