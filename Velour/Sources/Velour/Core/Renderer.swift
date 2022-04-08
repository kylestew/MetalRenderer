import Metal

open class Renderer {

    public var context: Context
//    public var scene: Object
//    public var camera: Camera

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

}
