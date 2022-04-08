import Metal
import MetalKit

open class Renderer: NSObject, MTKViewDelegate {

    public var device: MTLDevice!
    public var commandQueue: MTLCommandQueue!

    public weak var mtkView: MTKView! {
        didSet {
            if self.mtkView != nil {
                self.device = self.mtkView.device!

                guard let queue = self.device.makeCommandQueue() else { return }
                self.commandQueue = queue

                self.mtkView.depthStencilPixelFormat = .depth32Float_stencil8
                self.mtkView.colorPixelFormat = .bgra8Unorm

                self.setupMtkView(self.mtkView)

                self.setup()
            }
        }
    }

    public var sampleCount: Int {
        return self.mtkView.sampleCount
    }

    public var colorPixelFormat: MTLPixelFormat {
        return self.mtkView.colorPixelFormat
    }

    public var depthStencilPixelFormat: MTLPixelFormat {
        return self.mtkView.depthStencilPixelFormat
    }

    public var depthPixelFormat: MTLPixelFormat {
        return self.mtkView.depthStencilPixelFormat
    }

    public var stencilPixelFormat: MTLPixelFormat {
        if self.depthPixelFormat == .depth32Float {
            return .invalid
        }
        return self.mtkView.depthStencilPixelFormat
    }

    open func setupMtkView(_ metalKitView: MTKView) {}

    public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        self.resize((width: Float(size.width), height: Float(size.height)))
    }

    public func draw(in view: MTKView) {
        guard let _ = view.currentDrawable,
              let commandBuffer = self.preDraw() else {
            return
        }
        self.draw(view, commandBuffer)
        self.postDraw(view, commandBuffer)
    }

    open func preDraw() -> MTLCommandBuffer? {
        self.update()
        return self.commandQueue.makeCommandBuffer()
    }

    open func postDraw(_ view: MTKView, _ commandBuffer: MTLCommandBuffer) {
        guard let drawable = view.currentDrawable else { return }
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }

    open func setup() {}

    open func update() {}

    open func draw(_ view: MTKView, _ commandBuffer: MTLCommandBuffer) {}

    open func resize(_ size: (width: Float, height: Float)) {}

}
