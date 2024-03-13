//
//  DeeplinkDetailsView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import SwiftUI

struct DeeplinkDetailsView: View {
    @ObservedObject var viewModel: DeeplinkDetailsViewModel
    
    var body: some View {
        
        switch viewModel.dataState {
        case .empty:
            EmptyStateView(
                title: "You have't select any deeplink for opening",
                message: "Please select the deeplink for customization and perform"
            )
        case .loaded, .updated:
            ContentView(viewModel: viewModel)
        }
    }
    
    struct ContentView: View {
        @ObservedObject var viewModel: DeeplinkDetailsViewModel
        private let deeplinkOpener = AppDeeplinkOpener()

        var body: some View {
            GeometryReader { proxy in
                ScrollView {
                    VStack(spacing: .dimensionSpace3) {
                        DeeplinkInfoView()
                        DeeplinkParamListView(
                            params: viewModel.params,
                            onDataSourceChanged: viewModel.updateDeeplinkParams,
                            onRemovingParam: { index in
                                viewModel.removeDeeplinkParam(at: index)
                            },
                            onAddingNewParam: { index in
                                viewModel.addDeeplinkParam(at: index)
                            }
                        )
                        OpenButton()
                        Spacer()
                    }
                    .padding(.all, 64)
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
            }
        }

        private func DeeplinkInfoView() -> some View {
            VStack(spacing: .dimensionSpace4) {
                HStack {
                    Text("Deeplink: ")
                    Text(viewModel.deeplink)
                    Spacer()
                }
                InfoGroupView(
                    title: "Schema",
                    value: viewModel.schema,
                    onValueChanged: viewModel.updateDeeplinkSchema
                )
                InfoGroupView(
                    title: "Path",
                    value: viewModel.path,
                    onValueChanged: viewModel.updateDeeplinkPath
                )
            }
        }

        private func OpenButton() -> some View {
            Button {
                deeplinkOpener.openDeeplink(
                    viewModel.deeplink,
                    on: viewModel.selectedSimulator
                )
            } label: {
                HStack {
                    Spacer()
                    Text("Open")
                    Spacer()
                }
                .frame(height: .dimensionSpace10)
            }
            .buttonStyle(DSPrimaryButtonStyle())
            .padding(.top, .dimensionSpace15)
        }
    }
}

#Preview {
    DeeplinkDetailsView(
        viewModel: DeeplinkDetailsViewModel(
            deeplinkEntity: .init(
                id: "1",
                name: "SBOC Challenge Details",
                schema: "shopback",
                path: "challenge",
                params: [
                    DeeplinkParamEntity(key: "code", value: "X")
                ]
            ),
            selectedSimulator: Simulator(
                version: "16.0",
                name: "iPhone 14 (BCDEF12-34567890ABCDEF12)",
                uuid: "BCDEF12-34567890ABCDEF12",
                state: .shutdown
            ),
            deeplinkCombiner: DeeplinkCombiner()
        )
    )
    .frame(
        minWidth: 200,
        minHeight: 400
    )
}
