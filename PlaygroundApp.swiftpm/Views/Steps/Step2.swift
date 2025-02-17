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
            HStack {
                Image("left").resizable()
                    .border(spokenHand == "left" ? Color.blue : Color.clear, width: 5)
                Image("right").resizable()
                    .border(spokenHand == "right" ? Color.blue : Color.clear, width: 5)
                
            }
            .conditionalModifier(colorScheme == .dark) {
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
            .frame(width: 400, height: 200)
            .padding()
        }
    }
}

#Preview {
    Step2(spokenHand: .constant("left"))
}
