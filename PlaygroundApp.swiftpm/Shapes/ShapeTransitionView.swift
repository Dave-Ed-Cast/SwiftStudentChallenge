//
//  ShapeTransitionView.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 12/02/25.
//

import SwiftUI

struct ShapeTransitionView: View {
    
    @Binding var spokenShape: ShapeView.ShapeType
    
    @State private var xPositionIndex: Int = 0
    @State private var currentOffset: CGFloat = 0  // Store current offset
    @State var shapeIndex: Int = 0
    @State var randomize: Bool = false
    
    let shapeTypes: [ShapeView.ShapeType] = [.circle, .triangle, .square]
    
    var body: some View {
        let xOffsets: [CGFloat] = [-deviceWidth * 0.15, 0, deviceWidth * 0.15]
        
        ShapeView(type: spokenShape, strokeColor: randomize ? .red : .primary)
            .offset(x: currentOffset)
            .onAppear {
                Task {
                    while true {
                        try? await Task.sleep(nanoseconds: 1_250_000_000)
                        withAnimation(.interactiveSpring(duration: 0.5, extraBounce: 0.2, blendDuration: 0.3)) {
                            if randomize {
                                currentOffset = xOffsets.randomElement() ?? 0
                            } else {
                                currentOffset = 0
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
}
