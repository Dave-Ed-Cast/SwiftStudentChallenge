//
//  ShapeView.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 14/02/25.
//

import SwiftUI

struct ShapeView: View {
    let type: ShapeType
    let strokeColor: Color

    enum ShapeType {
        case circle, rectangle, triangle
    }

    var body: some View {
        switch type {
        case .circle:
            Circle().strokeBorder(strokeColor, lineWidth: 5)
        case .rectangle:
            Rectangle().strokeBorder(strokeColor, lineWidth: 5)
        case .triangle:
            Triangle().strokeBorder(strokeColor, lineWidth: 5)
        }
    }
}
