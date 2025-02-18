//
//  Step2.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step2: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var spokenHand: String
    
    var body: some View {
        VStack {
            Text(spokenHand != "none" ? "I heard: \(spokenHand)" : "Say one of the hands")
            HStack(spacing: 15) {
                Image("left")
                    .resizable()
                    .border(spokenHand == "left" ? Color.blue : Color.clear, width: 5)
                    .frame(width: deviceWidth * 0.15, height: deviceHeight * 0.2)
                Image("right")
                    .resizable()
                    .border(spokenHand == "right" ? Color.blue : Color.clear, width: 5)
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
                                self.spokenHand = lastWordString
                            }
                        }
                    }
                }
            }
            
            .padding()
        }
    }
}

#Preview {
    Step2(spokenHand: .constant("left"))
}
