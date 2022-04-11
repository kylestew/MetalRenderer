import Metal
import simd

open class Geometry {

    public var primitiveType: MTLPrimitiveType = .triangle
    public var windingOrder: MTLWinding = .counterClockwise
    public var indexType: MTLIndexType = .uint32

    public var vertexData: [Vertex] = []

    public var indexData: [UInt32] = []

    public var context: Context? {
        didSet {
            setup()
        }
    }

    public var vertexBuffer: MTLBuffer?
    public var indexBuffer: MTLBuffer?

    public init() {}

    public init(_ geometryData: inout GeometryData) {
        setFrom(&geometryData)
    }

    func setup() {
        setupVertexBuffer()
        setupIndexBuffer()
    }

    func setupVertexBuffer() {
        guard let context = context else { return }
        let device = context.device
        if !vertexData.isEmpty {
            let stride = MemoryLayout<Vertex>.stride
            let verticesSize = vertexData.count * stride

//            if let vertexBuffer = vertexBuffer,
//               vertexBuffer.length == verticesSize {
//
//            }

            vertexBuffer = device.makeBuffer(bytes: vertexData, length: verticesSize, options: [])
            vertexBuffer?.label = "Vertices"

        } else {
            vertexBuffer = nil
        }
    }

    func setupIndexBuffer() {
        guard let context = context else { return }
        let device = context.device

        let indicesSize = indexData.count * MemoryLayout.size(ofValue: indexData[0])
        indexBuffer = device.makeBuffer(bytes: indexData, length: indicesSize, options: [])
        indexBuffer?.label = "Indices"
    }

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

