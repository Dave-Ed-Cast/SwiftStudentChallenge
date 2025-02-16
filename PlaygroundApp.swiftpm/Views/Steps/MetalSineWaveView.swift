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
        view.autoResizeDrawable = true
        view.backgroundColor = .clear
//        view.clearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 0)
        view.clearColor = MTLClearColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: MTKView, context: Context) { }
}

struct Uniforms {
    var time: Float
    var amplitude: Float
    var frequency: Float // NEW
}

class Coordinator: NSObject, MTKViewDelegate {
    var device: MTLDevice!
    var commandQueue: MTLCommandQueue!
    var pipelineState: MTLRenderPipelineState!
    
    var time: Float = 0
    var amplitude: Float = 0.3
    var frequency: Float = 10.0
    
    var vertexBuffer: MTLBuffer!
    var uniformBuffer: MTLBuffer! // Store buffer persistently
    
    var audioManager = AudioManager()

    
    override init() {
        super.init()
        device = MTLCreateSystemDefaultDevice()
        commandQueue = device?.makeCommandQueue()
        setupPipeline()
        
        audioManager.onVolumeUpdate = { [weak self] level in
            DispatchQueue.main.async {
                self?.frequency = (level * 2500.0)
                self?.amplitude = (level * 50.0)
            }
        }
        
        uniformBuffer = device?.makeBuffer(length: MemoryLayout<Uniforms>.size, options: [])

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
        
        // 🔥 STEP 1: Recalculate sine wave vertices each frame
        let vertexCount = 100
        var vertices: [Float] = []
        
        for i in 0..<vertexCount {
            let x = -1.0 + 2.0 * (Float(i) / Float(vertexCount - 1))
            let y = amplitude * sin(frequency * x + time) // Reacts to frequency/amplitude!
            vertices.append(contentsOf: [x, y])
        }
        
        // 🔥 STEP 2: Update vertex buffer every frame
        vertexBuffer = device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Float>.size, options: [])
        
        renderEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        // 🔥 STEP 3: Update uniforms (time, frequency, amplitude)
        time += 0.05
        var uniforms = Uniforms(time: time, amplitude: amplitude, frequency: frequency)
        memcpy(uniformBuffer.contents(), &uniforms, MemoryLayout<Uniforms>.size)
        
        renderEncoder?.setVertexBuffer(uniformBuffer, offset: 0, index: 1)
        
        // 🔥 STEP 4: Draw updated sine wave
        renderEncoder?.drawPrimitives(type: .lineStrip, vertexStart: 0, vertexCount: vertexCount)
        
        renderEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
}
