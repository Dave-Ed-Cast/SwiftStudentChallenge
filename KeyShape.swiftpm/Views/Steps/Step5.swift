//
//  Step4.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step5: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var shape: ShapeView.ShapeType
    @Binding var hand: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("With your selection, you could apply it here")
                .accessibilityHint("Interact with the image below")
            
            MethodComponentView(hand: hand, shape: shape)
        }
        .frame(height: deviceHeight * 0.2)
        .padding()
    }
}

#Preview {
    Step5(shape: .constant(.circle), hand: .constant("left"))
}
