//
//  DeeplinkImportableView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 16/03/2024.
//

import SwiftUI

struct DeeplinkImportableView: View {
    
    @State var deeplink: String = ""
    var onImport: (String) -> Void
    
    init(onImport: @escaping (String) -> Void) {
        self.onImport = onImport
    }
    
    var body: some View {
        VStack(spacing: .dimensionSpace4) {
            TextField("Deeplink", text: $deeplink)
            Button(L10n.Common.Action.import) {
                onImport(deeplink)
            }
        }
        .frame(minWidth: 400)
        .padding(.all, .dimensionSpace4)
    }
}

#Preview {
    DeeplinkImportableView { deeplink in
        print(deeplink)
    }
}
