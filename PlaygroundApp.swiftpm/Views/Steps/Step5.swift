//
//  Step5.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step5: View {
    
    let config = UserDefaults.standard
    
    var body: some View {
        Image(config.string(forKey: "keyboard") ?? "none")
            .resizable()
            .scaledToFit()
            .padding()
            .frame(width: deviceWidth * 0.8)
    }
}



#Preview {
    Step5()
}
