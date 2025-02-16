//
//  ShapeTransitionView.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 12/02/25.
//

import SwiftUI

struct ShapeTransitionView: View {
    
    @State private var xPositionIndex: Int = 0
    @State var shapeIndex: Int
    @State var randomize: Bool = false
    
    let shapeTypes: [ShapeView.ShapeType] = [.circle, .square, .triangle]
    
    var body: some View {
        let xOffsets: [CGFloat] = [-deviceWidth * 0.15, 0, deviceWidth * 0.15]
        
        ShapeView(type: shapeTypes[shapeIndex], strokeColor: randomize ? .red : .primary)
            .frame(width: 100, height: 100)
            .offset(x: randomize ? xOffsets.randomElement()! : 0)
            .onAppear {
                Task {
                    while true {
                        try? await Task.sleep(nanoseconds: 1_250_000_000)
                        withAnimation(.interactiveSpring(duration: 0.5, extraBounce: 0.2, blendDuration: 0.3)) {
                            shapeIndex = (shapeIndex + 1) % shapeTypes.count
                            
                            if randomize {
                                xPositionIndex = (xPositionIndex + 1) % xOffsets.count
                            }
                        }
                    }
                }
            }
            .padding()
    }
}

#Preview {
    ShapeTransitionView(shapeIndex: 0)
}
