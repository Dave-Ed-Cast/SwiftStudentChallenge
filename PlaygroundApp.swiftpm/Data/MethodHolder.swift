//
//  MethodHolder.swift
//  KeyShape
//
//  Created by Davide Castaldi on 20/02/25.
//

import Foundation

struct ShapeEntry: Codable, Identifiable {
    var id: UUID = UUID()
    let name: String
    let shapeType: ShapeView.ShapeType
}

final class MethodHolder: ObservableObject {
    @Published var shapes: [ShapeEntry] = []
    
    private var fileURL: URL {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return directory.appendingPathComponent("shapes.json")
    }
    
    func saveToJSON() {
        do {
            let jsonData = try JSONEncoder().encode(shapes)
            try jsonData.write(to: fileURL)
        } catch {
            print("Error saving JSON: \(error)")
        }
    }
    
    func loadFromJSON() {
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let decodedShapes = try JSONDecoder().decode([ShapeEntry].self, from: jsonData)
            DispatchQueue.main.async {
                self.shapes = decodedShapes
            }
        } catch {
            print("Error loading JSON: \(error)")
        }
    }
    
    func addShape(name: String, shapeType: ShapeView.ShapeType) {
        shapes.append(ShapeEntry(name: name, shapeType: shapeType))
        saveToJSON()
    }
    
    func deleteShape(_ shape: ShapeEntry) {
        shapes.removeAll { $0.id == shape.id }
        saveToJSON()
    }
}
