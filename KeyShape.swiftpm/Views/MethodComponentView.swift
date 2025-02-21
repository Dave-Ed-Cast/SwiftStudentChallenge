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
            let shapeSize = deviceOrientation.isPortrait ? deviceWidth * 0.06 : deviceWidth * 0.05
            
            let imageWidth = deviceOrientation.isPortrait ? deviceWidth * 0.45 : deviceWidth * 0.25
            let imageHeight = deviceOrientation.isPortrait ? deviceWidth * 0.2 : deviceHeight * 0.1
            
            let alignment = (hand == "right" ? Alignment.leading : hand == "left" ? Alignment.trailing : Alignment.center)
            
            
            
            
            
            Image(hand).resizable()
                .frame(width: handSize, height: handSize)
                .accessibilityLabel("\(hand) hand.")
            
            Image("Native").resizable()
                .frame(width: imageWidth, height: imageHeight)
                .overlay(alignment: alignment) {
                    if hand == "right" || hand == "left" {
                        ShapeView(type: shape, strokeColor: .red)
                            .frame(width: shapeSize, height: shapeSize)
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
    }
}

#Preview {
    MethodComponentView(hand: "left", shape: .circle)
}
