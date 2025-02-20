//
//  Step1.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step1: View {
    
    @Binding var chosenShape: ShapeView.ShapeType
    
    @State private var recognizedText: String = ""
    
    let shapeTypes: [ShapeView.ShapeType] = [.circle, .triangle, .square, .unknown]
    
    var body: some View {
        
        VStack {
            Text(recognizedText != "" ? "I heard: \(recognizedText)" : "Say one of the shapes below")
                .accessibilityHint("Between circle, triangle and square choose or speak one")
                .font(.headline)
                .padding()
            
            HStack(spacing: 30) {
                ForEach(shapeTypes, id: \.self) { shape in
                    ShapeView(type: shape, strokeColor: shape == chosenShape ? .blue : .primary)
                        
                        .onTapGesture {
                            chosenShape = shape
                            recognizedText = String("\(shape)")
                        }
                        .accessibilityAddTraits(.isButton)
                        .accessibilityLabel(labelForShape(shape))
                        .accessibilityAction {
                            chosenShape = shape
                            recognizedText = String("\(shape)")
                        }
                        .frame(width: 100, height: 100)
                }
            }
            
        }
        .padding()
        .onAppear {
            let audioManager = AudioManager()
            audioManager.onTextUpdate = { text in
                DispatchQueue.main.async {
                    if let lastWord = text.split(separator: " ").last {
                        self.recognizedText = String(lastWord)
                        
                        switch lastWord.lowercased() {
                        case "circle":
                            chosenShape = .circle
                        case "square":
                            chosenShape = .square
                        case "triangle":
                            chosenShape = .triangle
                        default:
                            chosenShape = .unknown
                            recognizedText = "Not one of the shapes"
                        }
                    }
                }
            }
        }
    }
    
    private func labelForShape(_ shape: ShapeView.ShapeType) -> String {
        switch shape {
        case .circle:
            return "Circle. Double tap to select, then reach the bottom button to confirm selection"
        case .square:
            return "Square. Double tap to select, then reach the bottom button to confirm selection"
        case .triangle:
            return "Triangle. Double tap to select, then reach the bottom button to confirm selection"
        default:
            return "Unknown shape."
        }
    }
}

#Preview {
    Step1(chosenShape: .constant(.circle))
}
