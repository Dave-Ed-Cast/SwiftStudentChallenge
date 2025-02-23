//
//  ShapeRowView.swift
//  KeyShape
//
//  Created by Davide Castaldi on 22/02/25.
//

import SwiftUI

struct ShapeRowView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var tapped: Bool = false
    
    let shape: ShapeEntry
    let renameAction: () -> Void
    let deleteAction: () -> Void
    
    var body: some View {
        Button {
            renameAction()
        } label: {
            HStack(spacing: 20) {
                Text(shape.side)
                    .font(.headline)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .frame(width: deviceWidth * 0.06)
                ShapeView(type: shape.shapeType, strokeColor: .blue)
                    .frame(width: deviceWidth * 0.0425, height: deviceWidth * 0.0425)
                Text(shape.name)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                    .padding(.leading, 20)
            }
            
        }
        .swipeActions {
            Button(role: .destructive, action: deleteAction) {
                Label("Delete", systemImage: "trash")
            }
            .tint(.red)
            
            Button(action: renameAction) {
                Label("Rename", systemImage: "pencil")
            }
            .tint(.orange)
        }
        .frame(height: deviceOrientation.isPortrait ? deviceHeight * 0.03 : deviceHeight * 0.05)
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


