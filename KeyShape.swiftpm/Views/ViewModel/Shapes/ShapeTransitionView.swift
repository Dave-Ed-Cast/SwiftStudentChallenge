//
//  ShapeTransitionView.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 12/02/25.
//

import SwiftUI

struct ShapeTransitionView: View {
    
    @Binding var spokenShape: ShapeView.ShapeType
    
    @State private var xPositionIndex: Int = 1
    @State private var currentOffset: CGFloat = -15
    @State var shapeIndex: Int = 0
    @State var cycle: Bool = false
    
    let shapeTypes: [ShapeView.ShapeType] = [.circle, .triangle, .square]
    
    var body: some View {
        let xOffsets: [CGFloat] = [
            spokenShape != .triangle ? -deviceWidth * 0.1 : -deviceWidth * 0.12,
            spokenShape != .triangle ? -10 : -30,
            spokenShape != .triangle ? deviceWidth * 0.13 : deviceWidth * 0.12
        ]
        
            ShapeView(type: spokenShape, strokeColor: cycle ? .red : .primary)
                .offset(x: currentOffset)
                .onAppear {
                    currentOffset = xOffsets.first!
                    Task {
                        while true {
                            try? await Task.sleep(for: .seconds(2.5))
                            withAnimation(.interactiveSpring(duration: 0.5, extraBounce: 0.2, blendDuration: 0.3)) {
                                if cycle {
                                    currentOffset = xOffsets[xPositionIndex]
                                    xPositionIndex = (xPositionIndex + 1) % xOffsets.count
                                } else {
                                    currentOffset = -15
                                }
                            }
                        }
                    }
                }
        .padding()
    }
}

#Preview {
    ShapeTransitionView(spokenShape: .constant(.circle), shapeIndex: 0)
        .frame(width: 300, height: 300)
}
