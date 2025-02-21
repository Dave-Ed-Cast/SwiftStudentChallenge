//
//  Step4.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step4: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var shape: ShapeView.ShapeType
    @Binding var hand: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("With your selection, you could apply it here")
                .font(.headline)
                .accessibilityHint("Interact with the image below")
            
                MethodComponentView(hand: hand, shape: shape)            
            VStack {
                Text("KeyShape will only be saving your **method** for you!")
                Text("Hint: hold keyboard's letters and drag downwards for numbers or special character!")
            }
        }
        .frame(height: deviceHeight * 0.15)
        .padding()
    }
}

#Preview {
    Step4(shape: .constant(.circle), hand: .constant("left"))
}
