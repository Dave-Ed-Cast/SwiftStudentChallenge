//
//  Step5.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step5: View {
    
    let method = Text("method").fontWeight(.bold)
    let password = Text("password").fontWeight(.bold)
    var body: some View {
        VStack {
            Text("You're all set!")
                .font(.largeTitle)
            Text("Thank you for using KeyShape! Your generated \(method) is ready for you right after this step. Rest assured, your password is never stored. Only the method you selected is saved. This is so you can open the app and always find it! Feel free to associate your \(password) with a label!")
                .font(.title3)
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}

#Preview {
    Step5()
}
