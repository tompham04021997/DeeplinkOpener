//
//  DeeplinkItemView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import SwiftUI

protocol DeeplinkItemViewModelProtocol {
    
    var schema: String { get }
    
    var deeplink: String { get }
}

struct DeeplinkItemViewModel: DeeplinkItemViewModelProtocol {
    
    private let entity: DeeplinkEntity
    private let deeplinkParser: DeeplinkParserProtocol
    
    init(entity: DeeplinkEntity, deeplinkParser: DeeplinkParserProtocol = DeeplinkParser()) {
        self.entity = entity
        self.deeplinkParser = deeplinkParser
    }

    var schema: String {
        
        guard let deeplink = entity.deeplink,
              let shcema = try? deeplinkParser.getSchema(fromDeeplink: deeplink)
        else {
            return ""
        }
        
        return shcema
    }
    
    var deeplink: String {
        return entity.deeplink ?? ""
    }
}

struct DeeplinkItemView: View {
    
    @Binding var isSelected: Bool
    var viewModel: DeeplinkItemViewModelProtocol
    var deeplinkParser: DeeplinkParserProtocol = DeeplinkParser()
    
    var body: some View {
        HStack {
            Text(viewModel.deeplink)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
                .foregroundStyle(ForegroundStyle())
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.green.opacity(0.75))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay {
            RoundedRectangle(cornerRadius: 8).stroke(.white, lineWidth: 1.0)
        }
    }
}

#Preview {
    
    struct ContainerView: View {
        
        let entity = DeeplinkEntity(
            id: "1",
            deeplink: "shopback://challenge?code=SBOC_REJECTED_CASHBACK_06_03_2025",
            params: nil
        )
        
        var body: some View {
            DeeplinkItemView(
                isSelected: .constant(false),
                viewModel: DeeplinkItemViewModel(entity: entity)
            )
        }
    }
    
    return ContainerView()
        .padding(.all, 16)
}
