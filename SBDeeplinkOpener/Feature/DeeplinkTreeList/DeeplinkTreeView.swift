//
//  DeeplinkTreeView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 08/03/2024.
//

import SwiftUI

struct DeeplinkTreeView: View {
    
    private let deeplinkTreeItemFactory: any DeeplinkTreeItemViewFactoryProtocol = DeeplinkTreeItemViewFactory()
    var onSeletionItem: (DeeplinkTreeItemType) -> Void
    
    @StateObject var viewModel = DeeplinkTreeViewModel()
    
    var body: some View {
        Group {
            switch viewModel.dataState {
            case .loading:
                Text("Loading")
                
            case .loaded(let tree):
                List(tree.nodes, id: \.value, children: \.optionalChildren) { node in
                    AnyView(
                        deeplinkTreeItemFactory.createView(
                            forType: node.value,
                            onSelection: {
                                onSeletionItem(node.value)
                            },
                            onPerformAction: { type in
                                switch type {
                                case .createFolder:
                                    return
                                case .createDeeplink:
                                    return
                                }
                            }
                        )
                    )
                }
            }
        }
        .onAppear(perform: {
            Task {
                await viewModel.fetch()
            }
        })
    }
}

protocol DeeplinkTreeItemViewFactoryProtocol {
    
    associatedtype ContentView: View
    @ViewBuilder func createView(forType type: DeeplinkTreeItemType, onSelection: @escaping VoidCallBack, onPerformAction: @escaping (DeeplinkTreeActionType) -> Void) -> ContentView
}

final class DeeplinkTreeItemViewFactory {
    
}

enum DeeplinkTreeActionType {
    case createFolder
    case createDeeplink
}

extension DeeplinkTreeItemViewFactory: DeeplinkTreeItemViewFactoryProtocol {
    
    @ViewBuilder
    func createView(forType type: DeeplinkTreeItemType, onSelection: @escaping VoidCallBack, onPerformAction: @escaping (DeeplinkTreeActionType) -> Void) -> some View {
        switch type {
        case .folder(let name, _):
            TreeFolderView(title: name)
                .onTapGesture {
                    onSelection()
                }
                .contextMenu(
                    ContextMenu(
                        menuItems: {
                            Menu("Create") {
                                Button("Folder") {
                                    onPerformAction(.createFolder)
                                }
                                Button("Deeplink") {
                                    onPerformAction(.createDeeplink)
                                }
                            }
                        }
                    )
                )
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
