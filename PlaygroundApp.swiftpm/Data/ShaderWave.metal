//
//  File.metal
//  PlaygroundApp
//
//  Created by Davide Castaldi on 15/02/25.
//

#include <metal_stdlib>
using namespace metal;

// Define the struct at the top to avoid "Unknown type name 'Uniforms'"
struct Uniforms {
    float time;
    float amplitude;
    float frequency; // NEW
};

// Convert HSV to RGB
float3 hsv_to_rgb(float h, float s, float v) {
    float c = v * s;
    float x = c * (1.0 - fabs(fmod(h * 6.0, 2.0) - 1.0));
    float m = v - c;
    
    float3 rgb = (h < 1.0/6.0) ? float3(c, x, 0) :
    (h < 2.0/6.0) ? float3(x, c, 0) :
    (h < 3.0/6.0) ? float3(0, c, x) :
    (h < 4.0/6.0) ? float3(0, x, c) :
    (h < 5.0/6.0) ? float3(x, 0, c) :
    float3(c, 0, x);
    
    return rgb + float3(m, m, m);
}

// Vertex shader
struct VertexOut {
    float4 position [[position]];
    float3 color;
};

vertex VertexOut vertex_main(uint vertexID [[vertex_id]],
                             constant float2 *vertices [[buffer(0)]],
                             constant Uniforms &uniforms [[buffer(1)]]) {
    VertexOut out;
    float2 position = vertices[vertexID];
    position.y = uniforms.amplitude * sin(uniforms.frequency * position.x + uniforms.time);
    out.position = float4(position, 0.0, 1.0);
    
    float t = (position.x + 1.0) / 2.0;
    out.color = float3(
                       sin(6.28318 * (t + 0.0)),
                       sin(6.28318 * (t + 0.33)),
                       sin(6.28318 * (t + 0.66))
                       );
    
    return out;
}

fragment float4 fragment_main(VertexOut in [[stage_in]]) {
    return float4(in.color, 1.0);
}
