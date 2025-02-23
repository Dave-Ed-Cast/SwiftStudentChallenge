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
            let shapeSize = deviceOrientation.isPortrait ? deviceWidth * 0.14 : deviceWidth * 0.13
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
                ShapeTransitionView(spokenShape: $shape)
                    .frame(width: shapeSize, height: shapeSize)
                    .offset(y: shape == .square ? -deviceHeight * 0.025 : -deviceHeight * 0.019
                    )
                    .offset(y: deviceOrientation.isPortrait ? deviceHeight * 0.006 : -deviceHeight * 0.006)
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
