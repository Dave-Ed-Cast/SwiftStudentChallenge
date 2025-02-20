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
                    HStack(spacing: 30) {
                        Text(shape.side)
                            .font(.headline)
                        
                        ShapeView(type: shape.shapeType, strokeColor: .blue)
                            .frame(width: deviceWidth * 0.04, height: deviceWidth * 0.04)
                        
                        Text(shape.name)
                            .font(.caption)
                            .foregroundColor(.gray)

                    }
                    .swipeActions {
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
                    .foregroundStyle(.blue)
            }
            .padding()
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
        
        // Show Alert (Requires UIKit bridge)
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
    MethodListView()
        .environmentObject(MethodHolder())
}
