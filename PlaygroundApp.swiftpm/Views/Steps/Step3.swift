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
    
    var body: some View {
        VStack {
            Text("A possible password using this method: \(possiblePasswords.currentPassword)")
                .onAppear {
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
                .frame(
                    width: deviceOrientation.isPortrait ? 130 : 160,
                    height: deviceOrientation.isPortrait ? 130 : 150
                )
                .offset(y: -deviceHeight * 0.025)
            }
            .accessibilityLabel("")
            .accessibilityHint("Imagine the \(shape) you selected being typed on this keyboard for the next step.")
            .frame(width: deviceWidth * 0.6)
        }
        .onChange(of: shape) { newShape in
            possiblePasswords.updateShape(to: newShape)
        }
        .padding()
    }
}

#Preview {
    Step3(shape: .constant(.triangle))
}
