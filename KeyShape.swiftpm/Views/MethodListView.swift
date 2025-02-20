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
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(methodHolder.shapes) { shape in
                    HStack(spacing: 20) {
                        Text(shape.side)
                            .font(.headline)
                            .frame(width: deviceWidth * 0.06)
                        ShapeView(type: shape.shapeType, strokeColor: .blue)
                            .frame(width: deviceWidth * 0.0425, height: deviceWidth * 0.0425)
                        
                        Text(shape.name)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                            .padding(.leading, 20)
                        
                        Spacer()
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.gray.opacity(0.5))
                    }
                    
                    .swipeActions {
                        
                        Button(role: .destructive) {
                            methodHolder.deleteShape(shape)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                        
                        Button {
                            renameShape(shape)
                        } label: {
                            Label("Rename", systemImage: "pencil")
                        }
                        .tint(.orange)
                        
                    }
                }
                .onDelete(perform: deleteShape)
            }
            .onAppear {
                methodHolder.loadFromJSON()
            }
            .navigationTitle("Your combinations")
            
        }
        .overlay(alignment: .topTrailing) {
            Button {
                withAnimation {
                    view.value = .createPassword
                }
            } label: {
                Text("Create")
                    .padding()
                    .foregroundStyle(.blue)
            }
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
