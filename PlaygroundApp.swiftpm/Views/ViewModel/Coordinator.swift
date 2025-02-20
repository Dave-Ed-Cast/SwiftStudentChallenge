//
//  Coordinator.swift
//  PlaygroundApp
//
//  Created by Davide Castaldi on 16/02/25.
//

import MetalKit

fileprivate struct Uniforms {
    var time: Float
    var amplitude: Float
    var frequency: Float
}

final class Coordinator: NSObject, MTKViewDelegate, ObservableObject {

    var device: MTLDevice!
    var commandQueue: MTLCommandQueue!
    var pipelineState: MTLRenderPipelineState!
    
    var time: Float = 0
    var amplitude: Float = 0.3
    var frequency: Float = 10.0
    
    var vertexBuffer: MTLBuffer!
    var uniformBuffer: MTLBuffer!
    
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
        descriptor.vertexDescriptor = MTLVertexDescriptor()
        
        let blendDescriptor = descriptor.colorAttachments[0]!
        blendDescriptor.isBlendingEnabled = true
        blendDescriptor.rgbBlendOperation = .add
        blendDescriptor.alphaBlendOperation = .add
        blendDescriptor.sourceRGBBlendFactor = .sourceAlpha
        blendDescriptor.destinationRGBBlendFactor = .one
        blendDescriptor.sourceAlphaBlendFactor = .one
        blendDescriptor.destinationAlphaBlendFactor = .one
        
        pipelineState = try? device.makeRenderPipelineState(descriptor: descriptor)
        
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
        
        let vertexCount = 100
        var vertices: [Float] = []
        
        for i in 0..<vertexCount {
            let x = -1.0 + 2.0 * (Float(i) / Float(vertexCount - 1))
            let y = amplitude * sin(frequency * x + time)
            vertices.append(contentsOf: [x, y])
        }
        
        vertexBuffer = device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Float>.size, options: [])
        
        renderEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        time += 0.05
        var uniforms = Uniforms(time: time, amplitude: amplitude, frequency: frequency)
        memcpy(uniformBuffer.contents(), &uniforms, MemoryLayout<Uniforms>.size)
        
        renderEncoder?.setVertexBuffer(uniformBuffer, offset: 0, index: 1)
        
        let instanceCount = 25
        renderEncoder?.drawPrimitives(type: .lineStrip, vertexStart: 0, vertexCount: vertexCount, instanceCount: instanceCount)
        
        renderEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
}
