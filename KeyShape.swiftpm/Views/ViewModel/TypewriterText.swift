//
//  TypewriterText.swift
//  KeyShape
//
//  Created by Davide Castaldi on 21/02/25.
//

import SwiftUI
import AVKit

struct TypewriterText: View {
    let fullText: AttributedString
    @Binding var animationCompleted: Bool
    @State private var displayedText: AttributedString = ""
    
    var body: some View {
        Text(displayedText)
            .onAppear {
                displayedText = ""
                animationCompleted = false
                var currentIndex = fullText.startIndex
                Task {
                    while currentIndex < fullText.endIndex {
                        try? await Task.sleep(for: .seconds(0.6))
                        let nextIndex = fullText.index(currentIndex, offsetByCharacters: 1)
                        displayedText.append(fullText[currentIndex..<nextIndex])
                        currentIndex = nextIndex
                        
                        if currentIndex == fullText.endIndex {
                            animationCompleted = true
                            break
                        }
                    }
                }
            }
    }
}

#Preview {
    Step4()
}
