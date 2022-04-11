import Metal
import simd

open class Renderer {

    public var scene: Object
//    public var camera: Camera

    public var context: Context {
        didSet {
            scene.context = context
        }
    }

    public var size: (width: Float, height: Float) = (0, 0) {
        didSet {
            if oldValue.height != size.width || oldValue.height != size.height {
                let width = Double(size.width)
                let height = Double(size.height)
                viewport = MTLViewport(originX: 0.0, originY: 0.0, width: width, height: height, znear: 0.0, zfar: 1.0)
            }
        }
    }

    public var clearColor: MTLClearColor = MTLClearColorMake(0.0, 0.0, 0.0, 1.0)

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
    public init(context: Context, scene: Object) {
        self.scene = scene
        self.context = context
        self.scene.context = context // kicks off scene building (meshes, materials, shaders, etc)
    }

    public func setClearColor(_ color: simd_float4) {
        clearColor = .init(red: Double(color.x), green: Double(color.y), blue: Double(color.z), alpha: Double(color.w))
    }

    public func draw(
        renderPassDescriptor: MTLRenderPassDescriptor,
        commandBuffer: MTLCommandBuffer
    ) {

        renderPassDescriptor.colorAttachments[0].clearColor = clearColor
//        renderPassDescriptor.colorAttachments[0].loadAction = colorLoadAction

        if let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) {
            renderEncoder.setViewport(viewport)

//            if scene.visible {
//                draw(renderEncoder: renderEncoder, object: scene)
//            }

            renderEncoder.endEncoding()
        }
    }

    public func draw(renderEncoder: MTLRenderCommandEncoder, object: Object) {
//        if let mesh = object as? Mesh,
//           let material = mesh.material,
//           let pipeline = material.pipeline,
//           mesh.instanceCount > 0 {
//
//        }
    }

    public func resize(_ size: (width: Float, height: Float)) {
        self.size = size
    }

}
