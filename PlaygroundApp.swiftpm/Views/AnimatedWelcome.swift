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
        Text("Welcome to app.")
            .font(.largeTitle)
            .fontWeight(.bold)
            .matchedGeometryEffect(id: "Title", in: namespace)
    }
}
