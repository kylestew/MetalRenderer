import Metal
import simd

open class Geometry {

    public var primitiveType: MTLPrimitiveType = .triangle
    public var windingOrder: MTLWinding = .counterClockwise
    public var indexType: MTLIndexType = .uint32

    public var vertexData: [Vertex] = []

}

