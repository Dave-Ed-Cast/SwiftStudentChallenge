//
//  MethodHolder.swift
//  KeyShape
//
//  Created by Davide Castaldi on 20/02/25.
//

import Foundation

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
    
    init() {
        loadFromJSON()
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
                self.shapes = decodedShapes
            
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
}
