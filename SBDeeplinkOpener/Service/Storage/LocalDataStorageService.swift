//
//  LocalDataStorageService.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 13/03/2024.
//

import Foundation

final class LocalDataStorageService {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
}

extension LocalDataStorageService: DeeplinkDataStorageServiceProtocol {
    
    func read() async -> TreeList<DeeplinkTreeItemType> {
        let filePath = getDocumentsDirectory().appendingPathComponent("tree.json")
        do {
            let jsonData = try Data(contentsOf: filePath)
            let tree = try decoder.decode(TreeList<DeeplinkTreeItemType>.self, from: jsonData)
            return tree
        } catch {
            print("Failed to read tree: \(error)")
            let root = TreeList<DeeplinkTreeItemType>(
                [
                    TreeNode(
                        DeeplinkTreeItemType.folder(
                            name: "Deeplinks",
                            id: UUID().uuidString
                        ),
                        children: []
                    )
                ]
            )
            _ = await save(tree: root)
            return root
        }
    }
    
    
    func save(tree: TreeList<DeeplinkTreeItemType>) async -> Bool {
        do {
            let jsonData = try encoder.encode(tree)
            let filePath = getDocumentsDirectory().appendingPathComponent("tree.json")
            try jsonData.write(to: filePath)
            return true
        } catch {
            print("Failed to save tree: \(error)")
            return false
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let folderPath = documentsDirectory.appendingPathComponent("SBDeeplinkOpener")
        
        do {
            try FileManager.default.createDirectory(at: folderPath, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Failed to create directory: \(error)")
        }
        
        print("File Path :\(folderPath)")
        return folderPath
    }
}
