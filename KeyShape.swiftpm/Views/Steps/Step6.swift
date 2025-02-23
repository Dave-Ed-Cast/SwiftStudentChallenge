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
            Text("KeyShape will hold your \(method) for you, but never the characters for the \(password).")
            Text("You can create another one by mixing and matching shapes and hands!")
            Spacer()
        }
        .font(.title3)
        .multilineTextAlignment(.center)
        .padding()
        Spacer()
    }
}

#Preview {
    Step6()
}
