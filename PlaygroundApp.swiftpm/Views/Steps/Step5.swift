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
        VStack(alignment: .center, spacing: 10) {
            Text("Here is what you selected so far:")
            HStack {
                Group {
                    ShapeView(type: spokenShape, strokeColor: .blue)
                        .frame(width: 90, height: 90)
                    Image(spokenHand).resizable()
                        .frame(width: 150, height: 150)
                }
                .conditionalModifier(colorScheme == .dark) {
                    $0.colorInvert()
                }
                Image(keyboardChoice).resizable()
                    .frame(
                        width: 450,
                        height: keyboardChoice == "Traditional" ? 150 : 120
                    )
            }
            .frame(height: deviceHeight * 0.25)
            Text("Create it!")
                .font(.title3)
            Text("No password will be saved in this application. This will be yours alone.")
        }
    }
}

#Preview {
    Step5(spokenShape: .constant(.circle), spokenHand: .constant("left"), keyboardChoice: .constant("Native"))
}
