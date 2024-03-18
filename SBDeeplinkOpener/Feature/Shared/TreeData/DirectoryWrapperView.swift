//
//  DirectoryWrapperView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 17/03/2024.
//

import SwiftUI

struct DirectoryWrapperView<ContentView: View>: View {
    
    // MARK: - Properties
    
    let data: TreeNode<DirectoryType>
    let selection: TreeNode<DirectoryType>?
    let onSelection: VoidCallBack
    let onPerformAction: (TreeDataInteractionActionType) -> Void
    @ViewBuilder let contentView: () -> ContentView
    
    // MARK: - Data
    
    @State var showDirectoryNameEditableSheet = false
    @State var showCreateFolderSheet = false
    @State var showCreateFileSheet = false
    
    // MARK: - Initializers
    
    init(_ data: TreeNode<DirectoryType>,
         selection: TreeNode<DirectoryType>?,
         onSelection: @escaping VoidCallBack,
         onPerformAction: @escaping (TreeDataInteractionActionType) -> Void,
         @ViewBuilder contentView: @escaping () -> ContentView) {
        
        self.data = data
        self.onSelection = onSelection
        self.selection = selection
        self.onPerformAction = onPerformAction
        self.contentView = contentView
    }
    
    var body: some View {
        contentView()
            .onTapGesture {
                onSelection()
            }
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: .dimensionSpace3))
            .contextMenu(
                ContextMenu(
                    menuItems: {
                        if case .folder = data.value {
                            Menu(L10n.Common.Action.create) {
                                Button("Folder") {
                                    showCreateFolderSheet = true
                                }
                                Button("Deeplink") {
                                    showCreateFileSheet = true
                                }
                            }
                        }
                        
                        Button(L10n.Common.Action.remove) {
                            onPerformAction(.removeNode(node: data))
                        }
                        
                        Button(L10n.Common.Action.rename) {
                            showDirectoryNameEditableSheet = true
                        }
                    }
                )
            )
            .sheet(
                isPresented: $showDirectoryNameEditableSheet,
                content: {
                    DirectoryNameEditableView(
                        submitTitle: "Rename"
                    ){ newDirectoryName in
                        showDirectoryNameEditableSheet = false
                        let newData = createDirector(withNewName: newDirectoryName)
                        onPerformAction(.updateNodeValue(newValue: newData))
                    }
                }
            )
            .sheet(isPresented: $showCreateFolderSheet, content: {
                DirectoryNameEditableView(
                    submitTitle: L10n.Common.Action.create
                ) { folderName in
                    showCreateFolderSheet = false
                    onPerformAction(.createFolder(name: folderName))
                }
            })
            .sheet(isPresented: $showCreateFileSheet, content: {
                DirectoryNameEditableView(
                    submitTitle: L10n.Common.Action.create
                ) { fileName in
                    showCreateFileSheet = false
                    onPerformAction(.createDeeplink(name: fileName))
                }
            })
    }
    
    private func createDirector(withNewName name: String) -> DirectoryType {
        switch data.value {
        case .folder(_, let id):
            return .folder(name: name, id: id)
            
        case .deeplink(let data):
            var editableData = data
            editableData.setName(name)
            
            return .deeplink(
                data: editableData
            )
        }
    }
    
    private var backgroundColor: Color {
        if data.nodeID == selection?.nodeID {
            return Color.blue
        }
        
        return Color.clear
    }
}

#Preview {
    DirectoryWrapperView(
        TreeNode<DirectoryType>.folder(),
        selection: nil,
        onSelection: {
            
        },
        onPerformAction: { action in
            
        },
        contentView: {
            Text("OK")
        }
    )
}
