//
//  SimulatorInfoView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 11/03/2024.
//

import SwiftUI

struct SimulatorInfoView: View {
    
    let simulator: Simulator
    let selectionSimulator: Simulator
    var onSelection: VoidCallBack?
    
    var body: some View {
        HStack(alignment: .center) {
            IPhoneView()
            VStack {
                TitleView(title: simulator.name)
                DeviceIDView(id: simulator.uuid)
            }
            
            Spacer()
            
            VersionView(version: simulator.version)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        .background(backgroundColor)
        .onTapGesture {
            onSelection?()
        }
    }
    
    var backgroundColor: Color {
        if simulator.uuid == selectionSimulator.uuid {
            return Color.green
        }
        
        return Color.grey60
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
            HStack {
                Text(title)
                    .font(.system(size: 12, weight: .regular))
                Spacer()
            }
        }
    }
    
    struct DeviceIDView: View {
        
        let id: String
        var body: some View {
            HStack {
                Text(id)
                    .font(.system(size: 8, weight: .thin))
                Spacer()
            }
        }
    }
    
    struct VersionView: View {
        
        let version: String
        
        var body: some View {
            Text(version)
                .font(.system(size: 12).weight(.thin))
        }
    }
}

#Preview {
    SimulatorInfoView(
        simulator: Simulator(
            version: "16.0",
            name: "iPhone 14",
            uuid: "BCDEF12-34567890ABCDEF12",
            state: .booted
        ),
        selectionSimulator: Simulator(
            version: "16.0",
            name: "iPhone 14",
            uuid: "BCDEF12-34567890ABCDEF12",
            state: .booted
        )
    )
}
