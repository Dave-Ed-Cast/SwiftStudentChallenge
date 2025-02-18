//
//  Step4.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step3: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var chosenKeyboard: String
    
    var body: some View {
        VStack {
            Text(chosenKeyboard != "none" ? "I heard: \(chosenKeyboard)" : "Choose one")
            HStack {
                VStack {
                    Image("Traditional").resizable()
                        .border(chosenKeyboard == "Traditional" ? Color.blue : Color.clear, width: 5)
                    Text("Traditional").font(.headline)
                }
                VStack {
                    Image("Native").resizable()
                        .border(chosenKeyboard == "Native" ? Color.blue : Color.clear, width: 5)
                    Text("Native").font(.headline)
                }
            }
            .if(colorScheme == .dark) {
                $0.colorInvert()
            }
            .frame(
                width: deviceOrientation.isPortrait ? deviceWidth * 0.8: deviceWidth * 0.7,
                height: deviceOrientation.isPortrait ? deviceHeight * 0.15 : deviceHeight * 0.25
            )
            .onAppear {
                let audioManager = AudioManager()
                audioManager.onTextUpdate = { text in
                    DispatchQueue.main.async {
                        if let lastWord = text.split(separator: " ").last {
                            let lastWordString = String(lastWord).lowercased()
                            if lastWordString == "traditional" || lastWordString == "native" {
                                self.chosenKeyboard = lastWordString.capitalized
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
    Step3(chosenKeyboard: .constant("Traditional"))
}
