//
//  SimulatorInfoView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 11/03/2024.
//

import SwiftUI

struct SimulatorInfoViewModel {
    
    let entity: Simulator
    
    init(entity: Simulator) {
        self.entity = entity
    }
    
    var id: String {
        return entity.uuid
    }
    
    var title: String {
        return entity.name
    }
    
    var iOSVersion: String {
        return entity.version
    }
    
    var simulatorState: SimulatorState {
        return entity.state
    }
}

extension SimulatorInfoViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct SimulatorInfoView: View {
    
    let viewModel: SimulatorInfoViewModel
    @Binding var selectionSimulator: SimulatorInfoViewModel
    var onSelection: VoidCallBack?
    
    var body: some View {
        HStack(alignment: .center) {
            HStack(alignment: .center, spacing: 8) {
                StatusView(simulatorState: viewModel.simulatorState)
                IPhoneView()
                TitleView(title: viewModel.title)
            }
            
            Spacer()
            
            VersionView(version: viewModel.iOSVersion)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        .background(backgroundColor)
        .onTapGesture {
            selectionSimulator = viewModel
            onSelection?()
        }
    }
    
    var backgroundColor: Color {
        if viewModel.id == selectionSimulator.id {
            return Color.blue.opacity(0.25)
        }
        
        return Color.black.opacity(0.85)
    }
}

extension SimulatorInfoView {
    
    struct StatusView: View {
        
        let simulatorState: SimulatorState
        
        var body: some View {
            Circle()
                .fill(stateColor)
                .frame(width: 10, height: 10)
        }
        
        var stateColor: Color {
            switch simulatorState {
            case .shutdown:
                Color.red
            case .booted:
                Color.green
            }
        }
    }
    
    struct IPhoneView: View {
        var body: some View {
            Image("iphone")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .clipped()
        }
    }
    
    struct TitleView: View {
        let title: String
        
        var body: some View {
            Text(title)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color.white)
        }
    }
    
    struct VersionView: View {
        
        let version: String
        
        var body: some View {
            Text(version)
                .font(.system(size: 12).weight(.thin))
                .foregroundStyle(Color.white.opacity(0.7))
        }
    }
}

#Preview {
    SimulatorInfoView(
        viewModel: SimulatorInfoViewModel(
            entity: Simulator(
                version: "16.0",
                name: "iPhone 14",
                uuid: "BCDEF12-34567890ABCDEF12",
                state: .booted
            )
        ),
        selectionSimulator: .constant(SimulatorInfoViewModel(
            entity: Simulator(
                version: "16.0",
                name: "iPhone 14",
                uuid: "BCDEF12-34567890ABCDEF12",
                state: .booted
            )
        ))
    )
}
