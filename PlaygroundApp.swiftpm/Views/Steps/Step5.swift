//
//  Step5.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step5: View {
    
    @Binding var keyboardChoice: String
    
    var body: some View {
        Image(keyboardChoice)
            .resizable()
            .scaledToFit()
            .frame(width: deviceWidth * 0.8)
            .overlay {
                ShapeTransitionView(
                    shapeIndex: 0,
                    randomize: true
                )
            }
            .padding()
    }
}



#Preview {
    Step5(keyboardChoice: .constant("Traditional"))
}
