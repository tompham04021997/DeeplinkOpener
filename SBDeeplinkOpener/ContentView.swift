//
//  ContentView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            NavigationSplitView {
                FeatureListView()
                    .frame(minWidth: 100, minHeight: 450)
            }  content: {
                DeeplinkListView()
                    .frame(minWidth: 250, minHeight: 450)
                    .navigationTitle("Deeplink")
            } detail: {
                DeeplinkDetailsView()
                    .navigationTitle("Details")
            }
            
        }
        .padding()
        .frame(minWidth: 800, minHeight: 450)
    }
}

#Preview {
    ContentView()
}
