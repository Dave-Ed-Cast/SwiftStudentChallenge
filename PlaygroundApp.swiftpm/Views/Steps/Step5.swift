//
//  Step6.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step5: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var spokenShape: ShapeView.ShapeType
    @Binding var spokenHand: String
    @Binding var keyboardChoice: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            HStack {
                Image(spokenHand).resizable()
                    .frame(
                        width: deviceWidth * 0.075,
                        height: deviceWidth * 0.065
                    )
                
                Image(keyboardChoice).resizable()
                    .frame(
                        width: deviceWidth * 0.25,
                        height: keyboardChoice == "Traditional" ? deviceHeight * 0.125 : deviceHeight * 0.1
                    )
                    .overlay(alignment: spokenHand == "right" ? .leading : spokenHand == "left" ? .trailing : .center) {
                        if spokenHand == "right" || spokenHand == "left" {
                            ShapeView(type: spokenShape, strokeColor: .red)
                                .frame(
                                    width: deviceWidth * 0.05,
                                    height: deviceWidth * 0.05
                                )
                                .offset(x: spokenHand == "right" ? 170 : -170, y: keyboardChoice == "Native" ? -deviceHeight * 0.015 : 0)
                        }
                    }
                    .if(colorScheme == .dark) { view in
                        view.colorInvert()
                    }
            }
            .frame(height: deviceHeight * 0.15)
            
            VStack {
                Text("Now, let’s bring it all together! Unleash your creativity! have fun with it!")
                Text(keyboardChoice == "Native" ? "With iPad native keyboard, you can hold the letter and drag downwards to use a number or special character!" : "With traditional keyboard, you can hold shift with the other hand to use special characters!")
            }
//                .frame(height: deviceHeight * 0.04)
        }
    }
}

#Preview {
    Step5(spokenShape: .constant(.circle), spokenHand: .constant("left"), keyboardChoice: .constant("Native"))
}
