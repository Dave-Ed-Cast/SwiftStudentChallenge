//
//  Step4.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step4: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var shape: ShapeView.ShapeType
    @Binding var hand: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Look at how you can apply your selected shape to the keyboard for the password")
                .accessibilityHint("Interact with the image below")
            Text("Here is your selection so far:")
                .font(.headline)
            HStack {
                Image(hand).resizable()
                    .frame(width: deviceWidth * 0.075, height: deviceWidth * 0.065)
                    .accessibilityLabel("\(hand) hand.")
                Image("Native").resizable()
                    .frame(
                        width: deviceWidth * 0.25,
                        height: deviceHeight * 0.1
                    )
                    .overlay(alignment: hand == "right" ? .leading : hand == "left" ? .trailing : .center) {
                        if hand == "right" || hand == "left" {
                            ShapeView(type: shape, strokeColor: .red)
                                .frame(
                                    width: deviceWidth * 0.045,
                                    height: deviceWidth * 0.045
                                )
                                .offset(
                                    x: hand == "right" ? 170 : -170,
                                    y: -deviceHeight * 0.015
                                )
                        }
                    }
                    .if(colorScheme == .dark) { view in
                        view.colorInvert()
                    }
                    .accessibilityLabel("")
                    .accessibilityHint("This is the you \(shape) you chose. Now use your \(hand) hand, to create your password following the shape you chose! Chosing \(hand) hand, suggests to overlay the hand on the \(hand) side of the keyboard. Go downwards for input.")
            }
            
            VStack {
                Text("Unleash your creativity! Don't worry, the app won't store your password characters. Just have fun with it!")
                Text("With iPad native keyboard, you can hold the letter and drag downwards to use a number or special character!")
            }
        }
        .frame(height: deviceHeight * 0.15)
        .padding()
    }
}

#Preview {
    Step4(shape: .constant(.circle), hand: .constant("left"))
}
