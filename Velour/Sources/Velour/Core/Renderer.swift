import Metal
import simd

open class Renderer {

    public var context: Context
//    public var scene: Object
//    public var camera: Camera

    public var size: (width: Float, height: Float) = (0, 0) {
        didSet {
            if oldValue.height != size.width || oldValue.height != size.height {
                let width = Double(size.width)
                let height = Double(size.height)
                viewport = MTLViewport(originX: 0.0, originY: 0.0, width: width, height: height, znear: 0.0, zfar: 1.0)
            }
        }
    }

    public var viewport = MTLViewport() {
        didSet {
            _viewport = simd_make_float4(
                Float(viewport.originX),
                Float(viewport.originY),
                Float(viewport.width),
                Float(viewport.height)
            )
        }
    }
    private var _viewport: simd_float4 = .zero

//    public init(context: Context, scene: Object, camera: Camera) {
    public init(context: Context) {
        self.context = context
    }

    public var clearColor: MTLClearColor = MTLClearColorMake(0.0, 0.0, 0.0, 1.0)

    public func draw(
        renderPassDescriptor: MTLRenderPassDescriptor,
        commandBuffer: MTLCommandBuffer
    ) {

        if let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) {

            renderEncoder.endEncoding()
        }
    }

    public func resize(_ size: (width: Float, height: Float)) {
        self.size = size
    }

}
