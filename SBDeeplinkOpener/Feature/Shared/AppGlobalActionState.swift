//
//  AppGlobalActionState.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 18/03/2024.
//

import SwiftUI

final class AppGlobalActionState: ObservableObject {
    
    @Published var onRunDeeplink: Bool = false
    @Published var onSaveDeeplink: Bool = false
    @Published var onImportDeeplink: Bool = false
}
