//
//  Step3.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step3: View {
    
    @Binding var shape: ShapeView.ShapeType
    
    @StateObject private var possiblePasswords = PossiblePasswords()
    @State private var xOffset: CGFloat = 0
    
    var body: some View {
        VStack {
            Text("A possible password using this method: \(possiblePasswords.currentPassword)")
                .onAppear {
                    possiblePasswords.updateShape(to: shape)
                    possiblePasswords.startCycling()
                }
            
            ZStack {
                Image("Native")
                    .resizable()
                    .scaledToFit()
                ShapeTransitionView(
                    spokenShape: $shape,
                    shapeIndex: 0,
                    cycle: true
                )
                .frame(width: 160, height: 150)
                .offset(y: -deviceHeight * 0.025)
            }
            .accessibilityLabel("")
            .accessibilityHint("Imagine the \(shape) you selected being typed on this keyboard for the next step.")
            .frame(width: deviceWidth * 0.6)
        }
        .padding()
    }
}

#Preview("triangle") {
    Step3(shape: .constant(.triangle))
}

#Preview("circle") {
    Step3(shape: .constant(.circle))
}

#Preview("square") {
    Step3(shape: .constant(.square))
}
