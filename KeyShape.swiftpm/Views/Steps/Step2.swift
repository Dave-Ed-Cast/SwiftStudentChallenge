//
//  Step2.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step2: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var hand: String
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Text(hand != "none" ? "You picked: \(hand)" : "Pick one of the hands")
                .font(.headline)
                .accessibilityHint("Choose between left or right hand by tapping or speaking the name.")

            HStack(spacing: 15) {
                Image("left").resizable()
                    .accessibilityAddTraits(.isButton)
                    .accessibilityLabel("Left hand, double tap to select, then reach the bottom button.")
                    .accessibilityAction {
                        hand = "left"
                    }
                    .onTapGesture {
                        hand = "left"
                    }
                    .if(colorScheme == .dark) {
                        $0.colorInvert()
                    }
                    .border(hand == "left" ? Color.blue : Color.clear, width: 5)
                
                Image("right").resizable()
                    .accessibilityLabel("Right hand, double tap to select, then reach the bottom button.")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityAction {
                        hand = "right"
                    }
                    .onTapGesture {
                        hand = "right"
                    }
                    .if(colorScheme == .dark) {
                        $0.colorInvert()
                    }
                    .border(hand == "right" ? Color.blue : Color.clear, width: 5)
            }
            
            .frame(
                width: deviceOrientation.isPortrait ? deviceWidth * 0.4 : deviceWidth * 0.3,
                height: deviceOrientation.isPortrait ? deviceWidth * 0.2 : deviceWidth * 0.15
            )
            Spacer()
        }
        .padding()
    }
}

#Preview {
    Step2(hand: .constant("left"))
}
