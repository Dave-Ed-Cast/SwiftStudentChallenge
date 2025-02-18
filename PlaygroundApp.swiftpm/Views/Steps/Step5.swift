//
//  Step6.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step5: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var spokenShape: ShapeView.ShapeType
    @Binding var spokenHand: String
    @Binding var keyboardChoice: String

    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("Here is what you selected so far:")
            HStack {
                Group {
                    ShapeView(type: spokenShape, strokeColor: .blue)
                        .frame(
                            width: deviceWidth * 0.05,
                            height: deviceWidth * 0.05
                        )
                    
                    Image(spokenHand).resizable()
                        .frame(width: deviceWidth * 0.1, height: deviceWidth * 0.1)
                }
                .conditionalModifier(colorScheme == .dark) {
                    $0.colorInvert()
                }
                Image(keyboardChoice).resizable()
                    .frame(
                        width: deviceWidth * 0.25,
                        height: keyboardChoice == "Traditional" ? deviceHeight * 0.125 : deviceHeight * 0.1
                    )
            }
            .frame(height: deviceHeight * 0.125)
            Text("Create it!")
                .font(.title3)
            Text("No password will be saved in this application. This will be yours alone.")
        }
    }
}

#Preview {
    Step5(spokenShape: .constant(.circle), spokenHand: .constant("left"), keyboardChoice: .constant("Traditional"))
}
