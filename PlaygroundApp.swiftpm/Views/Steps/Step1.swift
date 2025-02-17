//
//  Step1.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step1: View {
    
    @Binding var spokenShape: ShapeView.ShapeType
    
    @State private var recognizedText: String = ""
    
    @State var randomize: Bool = false
    
    let shapeTypes: [ShapeView.ShapeType] = [.circle, .triangle, .square, .unknown]
    
    var body: some View {
        
        VStack {
            Text(recognizedText != "" ? "I heard: \(recognizedText)" : "Say one of the shapes below")
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
                            spokenShape = .unknown
                            recognizedText = "Not one of the shapes"
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Step1(spokenShape: .constant(.circle))
}
