import Foundation
import Metal
import MetalKit

class Renderer: NSObject {

    // reference to GPU hardware
    let device: MTLDevice

    // responsible for creating and organizing MTLCommandBuffers each frame
    let commandQueue: MTLCommandQueue

    // sets the information for the draw (shader functions, color depth) and how to read vertex data
    let pipelineState: MTLRenderPipelineState

    let mesh: MTKMesh
    let vertexBuffer: MTLBuffer

    var timer: Float = 0

    init?(mtkView: MTKView) {
        guard
            let device = MTLCreateSystemDefaultDevice(),
            let commandQueue = device.makeCommandQueue() else {
            fatalError("GPU not available")
        }
        self.device = device
        self.commandQueue = commandQueue
        mtkView.device = device

        let mdlMesh = Primitive.makeCube(device, size: 1)
        do {
            mesh = try MTKMesh(mesh: mdlMesh, device: device)
        } catch {
            fatalError(error.localizedDescription)
        }
        vertexBuffer = mesh.vertexBuffers[0].buffer

        do {
            pipelineState = try Renderer.buildRenderPipeline(
                device: device,
                pixelFormat: mtkView.colorPixelFormat,
                vertexDescriptor: MTKMetalVertexDescriptorFromModelIO(mdlMesh.vertexDescriptor)!)
        } catch {
            fatalError(error.localizedDescription)
        }

        // MTLBuffer - holds data (i.e. vertex data) in a form that can be sent to the GPU
    }

    private static func buildRenderPipeline(
        device: MTLDevice,
        pixelFormat: MTLPixelFormat,
        vertexDescriptor: MTLVertexDescriptor
    ) throws -> MTLRenderPipelineState  {
        let pipelineDescriptor = MTLRenderPipelineDescriptor()

        // add shaders to pipeline
        let library = device.makeDefaultLibrary()
        pipelineDescriptor.vertexFunction = library?.makeFunction(name: "vertex_main")
        pipelineDescriptor.fragmentFunction = library?.makeFunction(name: "fragment_main")

        pipelineDescriptor.vertexDescriptor = vertexDescriptor

        // set the output pixel format to match the pixel format of the metal kit view
        pipelineDescriptor.colorAttachments[0].pixelFormat = pixelFormat

        // compile the configured pipeline descriptor to a pipeline state object
        return try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
    }
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    }

    func draw(in view: MTKView) {
        guard
            // get an available command buffer
            let commandBuffer = commandQueue.makeCommandBuffer(),
            // get the default MTLRenderPassDescriptor from the MTKView
            let descriptor = view.currentRenderPassDescriptor,
            // compile renderPassDescriptor to an MTLRenderCommandEncoder
            let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: descriptor) else {
            return
        }

        // enable our render pipeline
        renderEncoder.setRenderPipelineState(pipelineState)

        // uniform
        timer += 0.05
        var currentTime = sin(timer)
        renderEncoder.setVertexBytes(&currentTime, length: MemoryLayout<Float>.stride, index: 1)

        // ???
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        for submesh in mesh.submeshes {
            renderEncoder.drawIndexedPrimitives(type: .triangle,
                                                indexCount: submesh.indexCount,
                                                indexType: submesh.indexType,
                                                indexBuffer: submesh.indexBuffer.buffer,
                                                indexBufferOffset: submesh.indexBuffer.offset)
        }

        // we're finished encoding drawing commands
        renderEncoder.endEncoding()

        // tell Metal to send the rendering result to the MTKView when rendering completes
        guard let drawable = view.currentDrawable else {
            return
        }
        commandBuffer.present(drawable)

        // send the encoded command buffer to the GPU
        commandBuffer.commit()
    }
}
