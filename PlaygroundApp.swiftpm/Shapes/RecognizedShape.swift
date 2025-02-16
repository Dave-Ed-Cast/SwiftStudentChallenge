//
//  ShapeTransitionView.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 12/02/25.
//

import SwiftUI

struct RecognizedShape: View {
    
    @State var randomize: Bool = false
    @State private var spokenShape: ShapeView.ShapeType?
    @State private var recognizedText: String = "Say something..."
    
    let shapeTypes: [ShapeView.ShapeType] = [.circle, .square, .triangle]
    
    var body: some View {
        
        VStack {
            Text(recognizedText != "Say something..." ? "I heard: \(recognizedText)" : "Say one of the shapes below")
                .font(.headline)
                .padding()
            
            HStack(spacing: 30) {
                ForEach(shapeTypes, id: \.self) { shape in
                    ShapeView(type: shape, strokeColor: shape == spokenShape ? .blue : .primary)
                        .frame(width: 100, height: 100)
                }
            }
            .padding()
        }
        .onAppear {
            let audioManager = AudioManager()
            audioManager.onTextUpdate = { text in
                DispatchQueue.main.async {
                    if let lastWord = text.split(separator: " ").last {
                        self.recognizedText = String(lastWord)
                        
                        switch lastWord.lowercased() {
                        case "circle":
                            spokenShape = .circle
                        case "square":
                            spokenShape = .square
                        case "triangle":
                            spokenShape = .triangle
                        default:
                            spokenShape = nil
                            recognizedText = "Not one of the shapes"
                        }
                    }
                }
            }
        }
    }
}
