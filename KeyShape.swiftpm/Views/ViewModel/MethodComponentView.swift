//
//  SwiftUIView.swift
//  KeyShape
//
//  Created by Davide Castaldi on 20/02/25.
//

import SwiftUI

struct MethodComponentView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let hand: String
    let shape: ShapeView.ShapeType
    
    var body: some View {
        HStack {
            
            let handSize = deviceOrientation.isPortrait ? deviceWidth * 0.125 : deviceWidth * 0.065
            let shapeSize = deviceOrientation.isPortrait ? deviceWidth * 0.05 : deviceWidth * 0.04
            let imageWidth = deviceOrientation.isPortrait ? deviceWidth * 0.6 : deviceWidth * 0.25
            let imageHeight = deviceOrientation.isPortrait ? deviceWidth * 0.15 : deviceHeight * 0.1
            
            Image(hand).resizable()
                .frame(width: handSize, height: handSize)
                .accessibilityLabel("\(hand) hand.")
                .if(colorScheme == .dark) {
                    $0.colorInvert()
                }
            
            Image("Native").resizable()
                .frame(width: imageWidth, height: imageHeight)
                .overlay {
                    ShapeView(type: shape, strokeColor: .red)
                        .frame(width: shapeSize, height: shapeSize)
                        .offset(
                            x: hand == "right" ? deviceWidth * 0.036 : -deviceWidth * 0.036,
                            y: -deviceHeight * 0.012
                        )
                        .offset(x: shape == .triangle ? deviceWidth * 0.008 : 0)
                    
                }
                .accessibilityLabel("")
                .accessibilityHint("This is the you \(shape) you chose. Now use your \(hand) hand, to create your password following the shape you chose! Chosing \(hand) hand, suggests to overlay the hand on the \(hand) side of the keyboard. Go downwards for input.")
        }
    }
}

#Preview {
    MethodComponentView(hand: "right", shape: .triangle)
}
