//
//  SimulatorListView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import SwiftUI

struct SimulatorListView: View {
    
    @StateObject var viewModel = SimulatorListViewModel()
    var onSelection: VoidCallBack?
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: .zero) {
                    ForEach(viewModel.items, id: \.id) { item in
                        SimulatorInfoView(
                            viewModel: item,
                            selectionSimulator: viewModel.selectedItem,
                            onSelection: {
                                viewModel.updateSelectedSimulator(item.entity)
                                onSelection?()
                            }
                        ).tag(item.id)
                    }
                }
            }
        }
    }
}

#Preview {
    SimulatorListView()
}
