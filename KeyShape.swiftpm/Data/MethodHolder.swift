//
//  MethodHolder.swift
//  KeyShape
//
//  Created by Davide Castaldi on 19/02/25.
//

import Foundation
import CryptoKit

struct ShapeEntry: Codable, Identifiable {
    let id: UUID
    let side: String
    let shapeType: ShapeView.ShapeType
    var name: String
}

final class MethodHolder: ObservableObject {
    @Published var shapes: [ShapeEntry] = []
    
    private var fileURL: URL {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return directory.appendingPathComponent("shapes.json")
    }
    
    
    private var key: SymmetricKey {
        if let keyData = UserDefaults.standard.data(forKey: "encryptionKey") {
            return SymmetricKey(data: keyData)
        } else {
            let newKey = SymmetricKey(size: .bits256)
            let newKeyData = newKey.withUnsafeBytes { Data($0) }
            UserDefaults.standard.set(newKeyData, forKey: "encryptionKey")
            return newKey
        }
    }
    init() {
        loadFromJSON()
    }
    
    func saveToJSON() {
        do {
            let jsonData = try JSONEncoder().encode(shapes)
            if let encryptedData = encrypt(jsonData) {
                try encryptedData.write(to: fileURL)
            }
        } catch {
            print("Error saving JSON: \(error)")
        }
    }
    
    func loadFromJSON() {
        do {
            let encryptedData = try Data(contentsOf: fileURL)
            if let decryptedData = decrypt(encryptedData) {
                let decodedShapes = try JSONDecoder().decode([ShapeEntry].self, from: decryptedData)
                self.shapes = decodedShapes
                
            } else {
                print("Failed to decrypt data.")
            }
        } catch {
            print("Error loading JSON: \(error)")
        }
    }
    
    func addShape(side: String, shapeType: ShapeView.ShapeType, name: String = "latest") {
        loadFromJSON()
        let newShape = ShapeEntry(id: .init(), side: side, shapeType: shapeType, name: name)
        shapes.insert(newShape, at: 0)
        saveToJSON()
    }
    
    func deleteShape(_ shape: ShapeEntry) {
        shapes.removeAll { $0.id == shape.id }
        saveToJSON()
    }
    
    func updateShapeLabel(id: UUID, newName: String) {
        if let index = shapes.firstIndex(where: { $0.id == id }) {
            shapes[index].name = newName
            saveToJSON()
        }
    }
    
    private func encrypt(_ data: Data) -> Data? {
        do {
            let sealedBox = try AES.GCM.seal(data, using: key)
            return sealedBox.combined
        } catch {
            print("Encryption Error: \(error)")
            return nil
        }
    }
    
    private func decrypt(_ data: Data) -> Data? {
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            return try AES.GCM.open(sealedBox, using: key)
        } catch {
            print("Decryption Error: \(error)")
            return nil
        }
    }
}
