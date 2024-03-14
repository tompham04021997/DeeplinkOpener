//
//  DeeplinkDetailsView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import SwiftUI

struct DeeplinkDetailsView: View {
    @ObservedObject var viewModel: DeeplinkDetailsViewModel
    @EnvironmentObject var treeManager: TreeDataManager
    
    var body: some View {
        
        switch viewModel.dataState {
        case .initialized:
            EmptyStateView(
                title: "You have't select any deeplink for opening",
                message: "Please select the deeplink for customization and perform"
            )
        case .loaded:
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
                            params: $viewModel.deeplinkParams
                        )
                        ActionButtons()
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
                    Text("Deeplink")
                    Text(viewModel.deeplink)
                    Spacer()
                    
                    Button(
                        action: {
                        
                    }, label: {
                        
                        HStack {
                            Image("import")
                                .resizable()
                                .scaledToFit()
                                .frame(width: DSIconSize.small, height: DSIconSize.small)
                            
                            Text("Import")
                        }
                        .padding(.all, 4)
                    })
                    
                }
                .padding(.vertical, .dimensionSpace2)
                InfoGroupView(title: "Schema", value: $viewModel.deeplinkSchema)
                InfoGroupView(title: "Path", value: $viewModel.deeplinkPath)
            }
        }

        private func ActionButtons() -> some View {
            HStack(spacing: .dimensionSpace4) {
                OpenButton()
                SaveButton()
            }
            .padding(.top, .dimensionSpace15)
        }
        
        private func OpenButton() -> some View {
            ActionButton(title: "Open") {
                deeplinkOpener.openDeeplink(
                    viewModel.deeplink,
                    on: viewModel.selectedSimulator
                )
            }
        }
        
        private func SaveButton() -> some View {
            ActionButton(
                title: "Save",
                isDisabled: !viewModel.isSavingButtonEnabled
            ) {
                viewModel.onSaveDeeplinkData = true
            }
        }
    }
}

extension DeeplinkDetailsView {
    struct ActionButton: View {
        
        let title: String
        let isDisabled: Bool
        var action: VoidCallBack?
        
        init(title: String, isDisabled: Bool = false, action: VoidCallBack? = nil) {
            self.title = title
            self.isDisabled = isDisabled
            self.action = action
        }
        
        var body: some View {
            Button {
                action?()
            } label: {
                HStack {
                    Spacer()
                    Text(title)
                        .font(.bodyM)
                        .foregroundStyle(.white)
                    Spacer()
                }
                .frame(width: 128, height: .dimensionSpace10)
            }
            .disabled(isDisabled)
            .buttonStyle(.borderedProminent)
            .tint(isDisabled ? .gray : .green)
        }
    }
}

#Preview {
    DeeplinkDetailsView(
        viewModel: DeeplinkDetailsViewModel(
            treeManager: TreeDataManager(),
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
