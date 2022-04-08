import Metal
import simd

open class Geometry {

    public var primitiveType: MTLPrimitiveType = .triangle
    public var windingOrder: MTLWinding = .counterClockwise
    public var indexType: MTLIndexType = .uint32

    public var vertexData: [Vertex] = []

    public var indexData: [UInt32] = []

    public var context: Context?

    public var vertexBuffer: MTLBuffer?
    public var indexBuffer: MTLBuffer?

    public func setFrom(_ geometryData: inout GeometryData) {
        let vertexCount = Int(geometryData.vertexCount)
        if vertexCount > 0, let data = geometryData.vertexData {
            vertexData = Array(UnsafeBufferPointer(start: data, count: vertexCount))
        } else {
            vertexData = []
        }

        let indexCount = Int(geometryData.indexCount) * 3
        if indexCount > 0, let data = geometryData.indexData {
            data.withMemoryRebound(to: UInt32.self, capacity: indexCount) { ptr in
                indexData = Array(UnsafeBufferPointer(start: ptr, count: indexCount))
            }
        } else {
            indexData = []
        }
    }

}

