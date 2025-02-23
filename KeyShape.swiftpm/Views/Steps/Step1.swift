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
            Spacer()
            Text(recognizedText != "" ? "You picked: \(recognizedText)" : "Pick one of the shapes below")
                .accessibilityHint("Between circle, triangle and square choose or speak one")
                .font(.headline)
                .padding()
            
            HStack(spacing: 0) {
                ForEach(shapeTypes, id: \.self) { shape in
                    Button {
                        chosenShape = shape
                        recognizedText = String("\(shape)")
                    } label: {
                        ShapeView(type: shape, strokeColor: shape == chosenShape ? .blue : .primary)
                            .padding()
                            .accessibilityAddTraits(.isButton)
                            .accessibilityLabel(labelForShape(shape))
                            .accessibilityAction {
                                chosenShape = shape
                                recognizedText = String("\(shape)")
                            }
                            .frame(
                                width: deviceOrientation.isPortrait ? deviceWidth * 0.15 : deviceWidth * 0.11,
                                height: deviceOrientation.isPortrait ? deviceWidth * 0.15 : deviceWidth * 0.11
                            )
                    }
                }
            }
            Spacer()
        }
        .if(chosenShape == .triangle) {
            $0.overlay(alignment: .bottom) {
                Text("Choosing triangle means pressing one of the keys three times when making the key shape.")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .frame(width: deviceWidth)
            }
        }
        .padding()
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
