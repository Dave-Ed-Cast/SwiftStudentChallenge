//
//  AnimatedWelcome.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 06/02/25.
//

import SwiftUI

struct AnimatedWelcome: View {
    
    var namespace: Namespace.ID
    
    var body: some View {
        VStack(spacing: 5) {
            Text("Welcome to KeyShape")
                .font(.largeTitle)
                .fontWeight(.bold)
                .matchedGeometryEffect(id: "Title", in: namespace)
            Text("Adaptive to the device. Best in landscape mode.")
                .font(.callout)
        }
    }
}
