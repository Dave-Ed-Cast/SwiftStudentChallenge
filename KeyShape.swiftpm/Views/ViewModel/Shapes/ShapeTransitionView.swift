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
    
    let shapeTypes: [ShapeView.ShapeType] = [.circle, .triangle, .square]
    
    var body: some View {
        let xOffsets: [CGFloat] = [
            spokenShape != .triangle ? -deviceWidth * 0.1 : -deviceWidth * 0.12,
            spokenShape != .triangle ? -10 : -30,
            spokenShape != .triangle ? deviceWidth * 0.13 : deviceWidth * 0.12
        ]
        
        ShapeView(type: spokenShape, strokeColor: .red)
            .offset(x: currentOffset)
            .onAppear {
                currentOffset = xOffsets.first!
                Task {
                    while true {
                        try? await Task.sleep(for: .seconds(2.5))
                        withAnimation(.interactiveSpring(duration: 0.5, extraBounce: 0.2, blendDuration: 0.3)) {
                            currentOffset = xOffsets[xPositionIndex]
                            xPositionIndex = (xPositionIndex + 1) % xOffsets.count
                        }
                    }
                }
                
            }
            .padding()
    }
}

#Preview {
    ShapeTransitionView(spokenShape: .constant(.circle))
        .frame(width: 300, height: 300)
}
