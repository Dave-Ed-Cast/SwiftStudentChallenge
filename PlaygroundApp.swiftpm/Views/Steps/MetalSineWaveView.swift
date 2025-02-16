//
//  SwiftUIView.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 15/02/25.
//

import SwiftUI
import MetalKit

struct MetalSineWaveView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> MTKView {
        let view = MTKView()
        view.device = MTLCreateSystemDefaultDevice()
        view.colorPixelFormat = .bgra8Unorm
        view.clearColor = MTLClearColor(red: 1, green: 1, blue: 1, alpha: 0)
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: MTKView, context: Context) { }
}

struct Uniforms {
    var time: Float
    var amplitude: Float
}

class Coordinator: NSObject, MTKViewDelegate {
    var device: MTLDevice!
    var commandQueue: MTLCommandQueue!
    var pipelineState: MTLRenderPipelineState!
    var time: Float = 0
    var amplitude: Float = 0.3 // Base amplitude
    var vertexBuffer: MTLBuffer!
    var audioManager = AudioManager()
    
    override init() {
        super.init()
        device = MTLCreateSystemDefaultDevice()
        commandQueue = device?.makeCommandQueue()
        setupPipeline()
        
        // 🎤 Update amplitude based on voice input
        audioManager.onVolumeUpdate = { [weak self] level in
            self?.amplitude = 0.1 + (level * 0.4) // Scale the amplitude
        }
    }
    
    func setupPipeline() {
        let library = device.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "vertex_main")
        let fragmentFunction = library?.makeFunction(name: "fragment_main")
        
        let descriptor = MTLRenderPipelineDescriptor()
        descriptor.vertexFunction = vertexFunction
        descriptor.fragmentFunction = fragmentFunction
        descriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        // ✅ Tell Metal we’re using per-vertex colors!
        descriptor.vertexDescriptor = MTLVertexDescriptor()
        
        pipelineState = try? device.makeRenderPipelineState(descriptor: descriptor)
        
        // 🎨 Generate sine wave vertices
        let vertexCount = 100
        var vertices: [Float] = []
        
        for i in 0..<vertexCount {
            let x = -1.0 + 2.0 * (Float(i) / Float(vertexCount - 1))
            let y = 0.3 * sin(10.0 * x)
            vertices.append(contentsOf: [x, y])
        }
        
        vertexBuffer = device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Float>.size, options: [])
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
              let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        renderEncoder?.setRenderPipelineState(pipelineState)
        renderEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        // ✅ Update uniforms (time + amplitude)
        time += 0.05
        var uniforms = Uniforms(time: time, amplitude: amplitude)
        let uniformBuffer = device.makeBuffer(bytes: &uniforms, length: MemoryLayout<Uniforms>.size, options: [])
        renderEncoder?.setVertexBuffer(uniformBuffer, offset: 0, index: 1)
        
        renderEncoder?.drawPrimitives(type: .lineStrip, vertexStart: 0, vertexCount: 100)
        
        renderEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
}
