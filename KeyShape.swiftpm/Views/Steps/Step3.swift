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
            let shapeSize = deviceOrientation.isPortrait ? deviceWidth * 0.158 : deviceWidth * 0.13
            Spacer()
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
                .frame(width: shapeSize + 10, height: shapeSize)
                .offset(
                    x: shape == .square ? -deviceWidth * 0.005 : 0,
                    y: shape == .square ? -deviceHeight * 0.015 : -deviceHeight * 0.0175
                )
            }
            .accessibilityLabel("")
            .accessibilityHint("Imagine the \(shape) you selected being typed on this keyboard for the next step.")
            .frame(width: deviceWidth * 0.6)
            Spacer()
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
