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
//            let shapeSize = deviceOrientation.isPortrait ? deviceWidth * 0.08 : deviceWidth * 0.04
            let shapeSize = deviceWidth * 0.08
//            let imageWidth = deviceOrientation.isPortrait ? deviceWidth * 0.6 : deviceWidth * 0.25
//            let imageHeight = deviceOrientation.isPortrait ? deviceWidth * 0.15 : deviceHeight * 0.1
            let imageWidth = deviceWidth * 0.6
            let imageHeight = deviceWidth * 0.15
            
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
                    //circle offsets
                        .if(shape == .circle) { circle in
                            if deviceOrientation.isPortrait {
                                circle.offset(
                                    x: hand == "right" ? deviceWidth * 0.135 : -deviceWidth * 0.149
                                )
                            } else {
                                circle.offset(
                                    x: hand == "right" ? deviceWidth * 0.088 : -deviceWidth * 0.1
                                )
                            }
                        }
                    //triangle offsets
                        .if(shape == .triangle) { triangle in
                            if deviceOrientation.isPortrait {
                                triangle.offset(
                                    x: hand == "right" ? deviceWidth * 0.115 : -deviceWidth * 0.125
                                )
                            } else {
                                triangle.offset(
                                    x: hand == "right" ? deviceWidth * 0.049 : -deviceWidth * 0.05
                                )
                            }
                        }
                    //square offset
                        .if(shape == .square) { square in
                            if deviceOrientation.isPortrait {
                                square.offset(
                                    x: hand == "right" ? deviceWidth * 0.135 : -deviceWidth * 0.11
                                )
                            } else {
                                square.offset(
                                    x: hand == "right" ? deviceWidth * 0.056 : -deviceWidth * 0.042
                                )
                            }
                        }
                        .offset(y: -deviceHeight * 0.012)
                }
                .accessibilityLabel("")
                .accessibilityHint("This is the you \(shape) you chose. Now use your \(hand) hand, to create your password following the shape you chose! Chosing \(hand) hand, suggests to overlay the hand on the \(hand) side of the keyboard. Go downwards for input.")
        }
    }
}

#Preview {
    VStack(spacing: 50) {
        
        VStack {
            MethodComponentView(hand: "right", shape: .circle)
            MethodComponentView(hand: "right", shape: .triangle)
            MethodComponentView(hand: "right", shape: .square)
        }
        
        VStack {
            MethodComponentView(hand: "left", shape: .circle)
            MethodComponentView(hand: "left", shape: .triangle)
            MethodComponentView(hand: "left", shape: .square)
        }
    }
}
