//
//  MethodListView.swift
//  KeyShape
//
//  Created by Davide Castaldi on 19/02/25.
//

import SwiftUI

struct MethodListView: View {
    
    @EnvironmentObject private var methodHolder: MethodHolder
    @EnvironmentObject private var view: Navigation
    
    @State private var swipedShapeID: UUID? = nil
    
    var body: some View {
        VStack {
            List {
                ForEach(methodHolder.shapes) { shape in
                    ShapeRowView(
                        shape: shape,
                        renameAction: { renameShape(shape) },
                        deleteAction: { methodHolder.deleteShape(shape) }
                    )
                }
                .onDelete(perform: deleteShape)
            }
            
            
            .navigationTitle("Your combinations")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: MainView()) {
                        Text("Create")
                            .foregroundStyle(.blue)
                    }
                }
            }
        }
                
        .onAppear {
            methodHolder.loadFromJSON()
        }
    }
    
    private func renameShape(_ shape: ShapeEntry) {
        let alert = UIAlertController(title: "Rename Label", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = shape.name
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            if let newName = alert.textFields?.first?.text, !newName.isEmpty {
                methodHolder.updateShapeLabel(id: shape.id, newName: newName)
            }
        })
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(alert, animated: true)
        }
    }
    
    private func deleteShape(at offsets: IndexSet) {
        offsets.forEach { index in
            let shape = methodHolder.shapes[index]
            methodHolder.deleteShape(shape)
        }
    }
}
#Preview {
    let methodHolder = MethodHolder()
    
    methodHolder.shapes = [
        ShapeEntry(id: UUID(), side: "left", shapeType: .circle, name: "default"),
        ShapeEntry(id: UUID(), side: "right", shapeType: .circle, name: "default"),
        ShapeEntry(id: UUID(), side: "left", shapeType: .square, name: "default"),
        ShapeEntry(id: UUID(), side: "right", shapeType: .square, name: "default"),
        ShapeEntry(id: UUID(), side: "left", shapeType: .triangle, name: "default"),
        ShapeEntry(id: UUID(), side: "right", shapeType: .triangle, name: "default"),
        
    ]
    
    return MethodListView().environmentObject(methodHolder)
}
