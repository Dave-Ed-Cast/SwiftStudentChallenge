//
//  Step2.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step2: View {
    
    @EnvironmentObject private var audioManager: AudioManager
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var hand: String
    
    var body: some View {
        VStack {
            Text(hand != "none" ? "I heard: \(hand)" : "Say one of the hands")
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
                    .border(hand == "left" ? Color.blue : Color.clear, width: 5)
                
                    .frame(width: deviceWidth * 0.15, height: deviceHeight * 0.2)
                Image("right").resizable()
                    .accessibilityLabel("Right hand, double tap to select, then reach the bottom button.")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityAction {
                        hand = "right"
                    }
                    .onTapGesture {
                        hand = "right"
                    }
                    .border(hand == "right" ? Color.blue : Color.clear, width: 5)
                    .frame(width: deviceWidth * 0.15, height: deviceHeight * 0.2)
            }
            .if(colorScheme == .dark) {
                $0.colorInvert()
            }
            .onAppear {
                let audioManager = AudioManager()
                audioManager.onTextUpdate = { text in
                    DispatchQueue.main.async {
                        if let lastWord = text.split(separator: " ").last {
                            let lastWordString = String(lastWord).lowercased()
                            if lastWordString == "left" || lastWordString == "right" {
                                self.hand = lastWordString
                            }
                        }
                    }
                }
            }            
        }
        .padding()
    }
}

#Preview {
    Step2(hand: .constant("left"))
}
