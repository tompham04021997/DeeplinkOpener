//
//  DeeplinkDetailsView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import SwiftUI

struct DeeplinkDetailsView: View {
    @StateObject var viewModel: DeeplinkDetailsViewModel
    
    var body: some View {
        
        Group {
            switch viewModel.dataState {
            case .empty:
                EmptyStateView(
                    title: L10n.Details.EmptyState.title,
                    message: L10n.Details.EmptyState.message
                )
                
            case .loaded:
                ContentView(viewModel: viewModel)
            }
        }
        .transition(.slide)
        .animation(.default, value: viewModel.dataState)
    }
    
    struct ContentView: View {
        
        @StateObject var viewModel: DeeplinkDetailsViewModel
        @State private var showCopyAlert = false
        @State private var showDeeplinkInputView = false
        
        var body: some View {
            GeometryReader { proxy in
                ScrollView {
                    VStack(spacing: .dimensionSpace3) {
                        DeeplinkInfoView()
                        DeeplinkParamListView(
                            params: $viewModel.deeplinkParams
                        )
                        Spacer()
                    }
                    .padding(.all, .dimensionSpace15)
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
            }
        }

        private func DeeplinkInfoView() -> some View {
            VStack(spacing: .dimensionSpace4) {
                HStack {
                    Text(L10n.Details.Fields.deeplink)
                    Text(viewModel.deeplink)
                    Spacer()
                    HStack {
                        CopyButton()
                        ImportButton()
                    }
                }
                .padding(.vertical, .dimensionSpace2)
                InfoGroupView(
                    title: L10n.Details.Fields.schema,
                    value: $viewModel.deeplinkSchema
                )
                InfoGroupView(
                    title: L10n.Details.Fields.path,
                    value: $viewModel.deeplinkPath
                )
            }
        }
        
        private func CopyButton() -> some View {
            Button(
                action: {
                    viewModel.onCopyDeeplinkTrigger = true
                    showCopyAlert = true
                },
                label: {
                    HStack {
                        Asset.copy.swiftUIImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: DSIconSize.small, height: DSIconSize.small)
                        
                        Text(L10n.Common.Action.copy)
                    }
                    .padding(.all, .dimensionSpace2)
                }
            )
            .alert(isPresented: $showCopyAlert) {
                Alert(
                    title: Text(
                        L10n.Common.Alert.Copy.title
                    ),
                    message: Text(
                        L10n.Common.Alert.Copy.message
                    ),
                    dismissButton: .default(
                        Text(
                            L10n.Common.Action.ok
                        )
                    )
                )
            }
        }
        
        private func ImportButton() -> some View {
            Button(
                action: {
                    showDeeplinkInputView = true
                },
                label: {
                    
                    HStack {
                        Asset.import.swiftUIImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: DSIconSize.small, height: DSIconSize.small)
                        
                        Text(L10n.Common.Action.import)
                    }
                    .padding(.all, .dimensionSpace2)
                }
            )
            .sheet(isPresented: $showDeeplinkInputView) {
                DeeplinkImportableView { deeplink in
                    showDeeplinkInputView = false
                    viewModel.onImportedDeeplinkTrigger = deeplink
                }
            }
        }
    }
}

#Preview {
    DeeplinkDetailsView(
        viewModel: DeeplinkDetailsViewModel()
    )
    .frame(
        minWidth: 200,
        minHeight: 400
    )
}
