//
//  ShapeTransitionView.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 12/02/25.
//

import SwiftUI

struct ShapeTransitionView: View {
    @State var shapeIndex: Int
    
    let shapes: [AnyView] = [
        AnyView(Circle().strokeBorder(Color.primary, lineWidth: 5)),
        AnyView(Rectangle().strokeBorder(Color.primary, lineWidth: 5)),
        AnyView(Triangle().strokeBorder(Color.primary, lineWidth: 5))
    ]
    
    var body: some View {
        shapes[shapeIndex]
            .frame(width: deviceWidth * 0.2, height: deviceWidth * 0.2)
            .onAppear {
                Task {
                    while true {
                        try? await Task.sleep(nanoseconds: 1_250_000_000)
                        withAnimation(.interactiveSpring(duration: 0.75, extraBounce: 0.2, blendDuration: 0.3)) {
                            shapeIndex = (shapeIndex + 1) % shapes.count
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
