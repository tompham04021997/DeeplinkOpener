//
//  DeeplinkTreeView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import SwiftUI

enum DeeplinkTreeItemType {
    case folder(name: String, id: String)
    case deeplink(data: DeeplinkEntity)
}

extension DeeplinkTreeItemType: Identifiable {
    var id: String {
        switch self {
        case .folder(_ , let id):
            return id
            
        case .deeplink(let data):
            return data.id
        }
    }
}

extension DeeplinkTreeItemType: Equatable {
    static func == (lhs: DeeplinkTreeItemType, rhs: DeeplinkTreeItemType) -> Bool {
        return lhs.id == rhs.id
    }
}

extension DeeplinkTreeItemType: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct DeeplinkTreeView: View {
    
    private let deeplinkTreeItemFactory: any DeeplinkTreeItemViewFactoryProtocol = DeeplinkTreeItemViewFactory()
    
    var onSeletionItem: (DeeplinkTreeItemType) -> Void
    
    @State var tree = TreeList<DeeplinkTreeItemType> {
        TreeNode(DeeplinkTreeItemType.folder(name: "Challenge", id: "1")) {
            TreeNode(
                DeeplinkTreeItemType.deeplink(
                    data: .init(
                        id: "1",
                        name: "SBOC Challenge Details",
                        schema: "shopback",
                        path: "challenge",
                        params: [
                            "code": "T4498609"
                        ]
                    )
                )
            )
            
            TreeNode(
                DeeplinkTreeItemType.deeplink(
                    data: .init(
                        id: "2",
                        name: "Home",
                        schema: "shopback",
                        path: "challenge",
                        params: nil
                    )
                )
            )
        }
    }
    
    var body: some View {
        List(tree.nodes, id: \.value, children: \.optionalChildren) { node in
            AnyView(
                deeplinkTreeItemFactory.createView(
                    forType: node.value,
                    onSelection: {
                        onSeletionItem(node.value)
                    }
                )
            )
        }
    }
}

protocol DeeplinkTreeItemViewFactoryProtocol {
    
    associatedtype ContentView: View
    @ViewBuilder func createView(forType type: DeeplinkTreeItemType, onSelection: @escaping VoidCallBack) -> ContentView
}

final class DeeplinkTreeItemViewFactory {
    
}

extension DeeplinkTreeItemViewFactory: DeeplinkTreeItemViewFactoryProtocol {
    
    @ViewBuilder
    func createView(forType type: DeeplinkTreeItemType, onSelection: @escaping VoidCallBack) -> some View {
        switch type {
        case .folder(let name, _):
            TreeFolderView(title: name)
                .onTapGesture {
                    onSelection()
                }
        case .deeplink(let data):
            DeeplinkFileView(title: data.name)
                .onTapGesture {
                    onSelection()
                }
        }
    }
}

#Preview {
    DeeplinkTreeView(onSeletionItem: { _ in
        
    })
        .frame(width: 250)
}
