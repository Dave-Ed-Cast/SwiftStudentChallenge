//
//  Step2.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct Step2: View {
    var body: some View {
        HStack {
            ShapeTransitionView(shapeIndex: 0)
            ShapeTransitionView(shapeIndex: 2)
        }
    }
}

#Preview {
    Step2()
}
