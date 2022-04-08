import Metal
import MetalKit

open class Renderer: NSObject, MTKViewDelegate {
    public func draw(in view: MTKView) {
    }


    public var device: MTLDevice!
    public var commandQueue: MTLCommandQueue!

    public weak var mtkView: MTKView! {
        didSet {
            if self.mtkView != nil {
                self.device = self.mtkView.device!

                guard let queue = self.device.makeCommandQueue() else { return }
                self.commandQueue = queue
            }
        }
    }

    public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    }

}
