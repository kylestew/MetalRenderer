import Metal

public func StandardVertexDescriptor() -> MTLVertexDescriptor {
    // position
    let vertexDescriptor = MTLVertexDescriptor()

    vertexDescriptor.attributes[0].format = MTLVertexFormat.float4
    vertexDescriptor.attributes[0].offset = 0
    vertexDescriptor.attributes[0].bufferIndex = 0

    // normal
    vertexDescriptor.attributes[1].format = MTLVertexFormat.float3
    vertexDescriptor.attributes[1].offset = MemoryLayout<Float>.size * 4
    vertexDescriptor.attributes[1].bufferIndex = 0

    // uv
    vertexDescriptor.attributes[2].format = MTLVertexFormat.float2
    vertexDescriptor.attributes[2].offset = MemoryLayout<Float>.size * 8
    vertexDescriptor.attributes[2].bufferIndex = 0

    vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
    vertexDescriptor.layouts[0].stepRate = 1
    vertexDescriptor.layouts[0].stepFunction = .perVertex

    return vertexDescriptor
}
