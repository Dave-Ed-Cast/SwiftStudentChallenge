//
//  Step5.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step4: View {
    
    @Binding var keyboardChoice: String
    @Binding var spokenShape: ShapeView.ShapeType

    var body: some View {
        ZStack {
            Image(keyboardChoice)
                .resizable()
                .scaledToFit()
            ShapeTransitionView(
                spokenShape: $spokenShape,
                shapeIndex: 0,
                cycle: true
            )
            .frame(
                width: deviceOrientation.isPortrait ? 130 : 160,
                height: deviceOrientation.isPortrait ? 130 : 150
            )
            .offset(y: keyboardChoice == "Native" ? -deviceHeight * 0.025 : 0)
        }
        
        .frame(width: deviceWidth * 0.6)
        .padding()
    }
}



#Preview {
    Step4(keyboardChoice: .constant("Native"), spokenShape: .constant(.triangle))
}
