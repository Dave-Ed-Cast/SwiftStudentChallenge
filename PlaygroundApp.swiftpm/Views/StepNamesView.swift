//
//  SwiftUIView.swift
//  KeyShape
//
//  Created by Davide Castaldi on 19/02/25.
//

import SwiftUI

struct StepNamesView: View {
    
    let currentStep: Int
    let stepName = Steps.stepsArray
    let stepDescription = Steps.descriptionArray
    
    var body: some View {
        Group {
            Text(stepName[currentStep])
                .font(.largeTitle)
            formattedDescription(for: stepDescription[currentStep])
                .font(.title2)
        }
    }
    
    private func formattedDescription(for text: String) -> Text {
        let keywords = ["password", "keyboard", "preferences", "creativity", "technique", "shape", "hand", "press it", "say it", "keyboards", "every keyboard", "determine"]
        
        var formattedText = Text("")
        let words = text.components(separatedBy: " ")
        
        for word in words {
            if keywords.contains(word.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: ".", with: "")) {
                formattedText = formattedText + Text(" \(word)").bold()
            } else {
                formattedText = formattedText + Text(" \(word)")
            }
        }
        
        return formattedText
    }
}

#Preview {
    StepNamesView(currentStep: 0)
}
