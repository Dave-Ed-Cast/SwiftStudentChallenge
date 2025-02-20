//
//  ShaderWave.metal
//  PlaygroundApp
//
//  Created by Davide Castaldi on 15/02/25.
//

#include <metal_stdlib>
using namespace metal;

struct Uniforms {
    float time;
    float amplitude;
    float frequency;
};

struct VertexOut {
    float4 position [[position]];
    float3 color;
    float alpha;
};

vertex VertexOut vertex_main(uint vertexID [[vertex_id]],
                             constant float2 *vertices [[buffer(0)]],
                             constant Uniforms &uniforms [[buffer(1)]],
                             uint instanceID [[instance_id]]) {
    VertexOut out;
    float2 position = vertices[vertexID];
    
    
    float shift = float(instanceID) * 0.1;
    position.x += shift;
    
    position.y = uniforms.amplitude * sin(uniforms.frequency * position.x + uniforms.time);
    out.position = float4(position, 0.0, 1.0);
    
    float t = (position.x + 1.0) / 2.0;
    out.color = float3(
                       sin(6.28318 * (t + 0.0)),
                       sin(6.28318 * (t + 0.33)),
                       sin(6.28318 * (t + 0.66))
                       );
    
    out.alpha = 0.6 + 0.4 * (1.0 - abs(position.y));
    
    return out;
}

fragment float4 fragment_main(VertexOut in [[stage_in]]) {
    return float4(in.color, in.alpha);
}
