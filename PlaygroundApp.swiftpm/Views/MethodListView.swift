//
//  MethodListView.swift
//  KeyShape
//
//  Created by Davide Castaldi on 19/02/25.
//

import SwiftUI

struct MethodListView: View {
    
    @EnvironmentObject private var methodHolder: MethodHolder
    
    var body: some View {
        List {
            ForEach(methodHolder.shapes) { shape in
                HStack(spacing: 5) {
                    Text(shape.name)
                        .font(.headline)
                    
                    ShapeView(type: shape.shapeType, strokeColor: .blue)
                        .frame(width: 50, height: 50)
                }
            }
            .onDelete(perform: deleteShape)
        }
        .onAppear {
            methodHolder.loadFromJSON()
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
