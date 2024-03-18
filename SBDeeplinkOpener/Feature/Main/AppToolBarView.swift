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
    
    
    @Published var selectedSimulatorViewModel: SimulatorInfoViewModel = .init(
        entity: .init(
            version: .empty,
            name: .empty,
            uuid: .empty,
            state: .shutdown
        )
    )
    
    private var cancellables = Set<AnyCancellable>()
    @LazyInjected(\.simulatorDataObserverManager) var simulatorDataObserverManager
    
    init() {
        simulatorDataObserverManager.$selectedSimulator
            .compactMap { $0 }
            .map { SimulatorInfoViewModel(entity: $0) }
            .assign(to: \.selectedSimulatorViewModel, on: self)
            .store(in: &cancellables)
    }
}

struct AppToolBarView: View {
    
    @StateObject var viewModel = AppToolBarViewModel()
    @State var isPickerPresented = false
    
    var body: some View {
        SimulatorInfoView(
            viewModel: viewModel.selectedSimulatorViewModel,
            selectionSimulator: viewModel.selectedSimulatorViewModel,
            onSelection: {
                isPickerPresented = true
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: .dimensionSpace3))
        .popover(isPresented: $isPickerPresented) {
            SimulatorListView() {
                isPickerPresented = false
            }
            .frame(minWidth: 300, minHeight: 600)
            
        }
    }
}

#Preview {
    AppToolBarView()
}
