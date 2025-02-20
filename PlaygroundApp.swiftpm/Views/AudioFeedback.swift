//
//  AudioFeedback.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 15/02/25.
//

import SwiftUI
import MetalKit

struct AudioFeedback: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> MTKView {
        let view = MTKView()
        view.device = MTLCreateSystemDefaultDevice()
        view.colorPixelFormat = .bgra8Unorm
        view.autoResizeDrawable = true
        view.backgroundColor = .clear
        view.clearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 0)
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: MTKView, context: Context) { }
}
