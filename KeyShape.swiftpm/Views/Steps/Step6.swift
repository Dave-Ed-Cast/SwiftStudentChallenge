//
//  Step5.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step6: View {
    
    let method = Text("method").fontWeight(.bold)
    let password = Text("password").fontWeight(.bold)
    var body: some View {
        VStack {
            Spacer()
            Text("You're all set!")
                .font(.largeTitle)
            Text("Your generated \(method) will be stored for you to remember. Only the \(method) is saved, not the passowrd. Feel free to associate your \(password) with a label!")
                .font(.title3)
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding()
        Spacer()
    }
}

#Preview {
    Step6()
}
