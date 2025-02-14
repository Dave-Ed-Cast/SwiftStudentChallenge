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
        AnyView(Circle().strokeBorder(Color.black, lineWidth: 2)),
        AnyView(Rectangle().strokeBorder(Color.black, lineWidth: 2)),
        AnyView(Triangle().strokeBorder(Color.black, lineWidth: 2))
    ]
    
    var body: some View {
        shapes[shapeIndex]
            .frame(width: deviceWidth * 0.2, height: deviceWidth * 0.2)
            .transition(.opacity)
            .onAppear {
                Task {
                    while true {
                        try? await Task.sleep(nanoseconds: 1_500_000_000)
                        shapeIndex = (shapeIndex + 1) % shapes.count
                    }
                }
            }
        
            .padding()
    }
}

#Preview {
    ShapeTransitionView(shapeIndex: 0)
}
