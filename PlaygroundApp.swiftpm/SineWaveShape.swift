//
//  SineWaveShape.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 12/02/25.
//

import SwiftUI

struct SineWaveShape: Shape {
    var phase: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let amplitude: CGFloat = 50
        let frequency: CGFloat = 1.5
        
        path.move(to: CGPoint(x: 0, y: rect.midY))
        
        for x in stride(from: 0, to: rect.width, by: 1) {
            let sine = sin((x / rect.width) * .pi * frequency + phase * .pi / 180)
            let y = rect.midY + sine * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        return path
    }
}
