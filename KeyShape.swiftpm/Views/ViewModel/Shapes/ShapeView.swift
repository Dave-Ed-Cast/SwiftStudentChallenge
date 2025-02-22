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
    
    enum ShapeType: String, Codable {
        case circle, triangle, square, unknown
    }
    
    var body: some View {
        switch type {
        case .circle:
            Circle().strokeBorder(strokeColor, lineWidth: 5)
        case .triangle:
            Triangle().strokeBorder(strokeColor, lineWidth: 5)
        case .square:
            Rectangle().strokeBorder(strokeColor, lineWidth: 5)
        default:
            EmptyView()
        }
    }
}
