//
//  DeeplinkDetailsView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import SwiftUI

struct DeeplinkDetailsView: View {
    
    @Binding var deeplinkEntity: DeeplinkEntity?
    let selectedSimulator: Simulator
    
    private let deeplinkCombiner: DeeplinkCombinerProtocol = DeeplinkCombiner()
    
    var body: some View {
        
        if let deeplinkEntity {
            GeometryReader { proxy in
                VStack {
                    InfoGroupView(
                        title: "Deeplink",
                        value: .constant(
                            deeplinkCombiner.combineToDeeplink(
                                fromEntity: deeplinkEntity
                            )
                        )
                    )
                    Spacer()
                    
                    Button {
                        AppDeeplinkOpener().openDeeplink(
                            deeplinkCombiner.combineToDeeplink(
                                fromEntity: deeplinkEntity
                            ),
                            on: selectedSimulator
                        )
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
        } else {
            Text("Please select a deeplink")
        }
    }
}

#Preview {
    DeeplinkDetailsView(
        deeplinkEntity: .constant(
            .init(
                id: "1",
                name: "SBOC Challenge Details",
                schema: "shopback",
                path: "challenge",
                params: [
                    "code": "T4498609"
                ]
            )
        ),
        selectedSimulator: Simulator(
            version: "16.0",
            name: "iPhone 14 (BCDEF12-34567890ABCDEF12)",
            uuid: "BCDEF12-34567890ABCDEF12",
            state: .shutdown
        )
    )
        .frame(minWidth: 200, minHeight: 400)
}
