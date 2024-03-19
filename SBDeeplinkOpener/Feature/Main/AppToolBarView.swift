//
//  AppToolBarView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 18/03/2024.
//

import SwiftUI
import Factory
import Combine
final class AppToolBarViewModel: ObservableObject {
    
    @Published var selectedSimulator: Simulator = .init(
        version: .empty,
        name: .empty,
        uuid: .empty,
        state: .shutdown
    )
    
    private var cancellables = Set<AnyCancellable>()
    @LazyInjected(\.simulatorDataObserverManager) var simulatorDataObserverManager
    
    init() {
        simulatorDataObserverManager.$selectedSimulator
            .compactMap { $0 }
            .removeDuplicates()
            .assign(to: \.selectedSimulator, on: self)
            .store(in: &cancellables)
    }
}

struct AppToolBarView: View {
    
    @StateObject var viewModel = AppToolBarViewModel()
    @State var isSimulatorPickerPresented = false
    @InjectedObject(\.appGlobalActionState) var appGlobalActionState
    
    var body: some View {
        
        Group {
            HStack {
                HStack(spacing: .dimensionSpace3) {
                    ToolBarButton(image: Asset.play.swiftUIImage)
                        .onTapGesture {
                            appGlobalActionState.onRunDeeplink = true
                        }
                    SimulatorView(entity: viewModel.selectedSimulator)
                        .onTapGesture {
                            isSimulatorPickerPresented = true
                        }
                        .popover(isPresented: $isSimulatorPickerPresented) {
                            SimulatorListView() {
                                isSimulatorPickerPresented = false
                            }
                            .frame(minWidth: 300, minHeight: 600)
                            
                        }
                }
            }
            .padding(.all, .dimensionSpace3)
            
            Spacer()
            
            HStack {
                ToolBarButton(image: Asset.import.swiftUIImage)
                ToolBarButton(image: Asset.save.swiftUIImage)
                ToolBarButton(image: Asset.trash.swiftUIImage)
            }
        }
        .padding(.trailing, .dimensionSpace4)
    }
}

extension AppToolBarView {
    
    struct SimulatorView: View {
        
        let entity: Simulator
        
        init(entity: Simulator) {
            self.entity = entity
        }
        
        var body: some View {
            HStack(spacing: .dimensionSpace10) {
                HStack(spacing: .dimensionSpace1) {
                    Asset.iphone.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: DSIconSize.small, height: DSIconSize.small)
                        .clipped()
                    
                    Text(entity.name)
                }
                
                HStack(spacing: .dimensionSpace1) {
                    Text(entity.version)
                    Asset.downArrow.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: DSIconSize.small, height: DSIconSize.small)
                        .clipped()
                }
            }
            .padding(.horizontal, .dimensionSpace3)
            .padding(.vertical, .dimensionSpace2)
            .background(Color.grey60)
            .overlay {
                RoundedRectangle(cornerRadius: .dimensionSpace3)
                    .stroke(.white, lineWidth: 0.5)
            }
        }
    }
}

extension AppToolBarView {
    
    struct ToolBarButton: View {
        
        let image: Image
        
        var body: some View {
            image
                .resizable()
                .scaledToFit()
                .frame(width: DSIconSize.small, height: DSIconSize.small)
                .padding(.vertical, .dimensionSpace2_5)
                .padding(.horizontal, .dimensionSpace4)
                .background(Color.grey60)
                .clipShape(RoundedRectangle(cornerRadius: .dimensionSpace3))
                .clipped()
        }
    }
}

#Preview {
    HStack {
        AppToolBarView()
    }
}
