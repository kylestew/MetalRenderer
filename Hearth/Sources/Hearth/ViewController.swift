import UIKit
import MetalKit

open class ViewController: UIViewController {

    open var mtkView: MTKView?

    var drawableSize: CGSize = .zero

    open var renderer: Renderer? {
        willSet {
            if let mtkView = self.mtkView,
               let _ = self.renderer {
                mtkView.delegate = nil
                drawableSize = .zero
            }
        }
        didSet {
            setupRenderer()
        }
    }

    public init(renderer: Renderer?) {
        super.init(nibName: nil, bundle: nil)
        self.renderer = renderer
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        mtkView?.delegate = nil
        renderer = nil
    }

    open override func loadView() {
        view = MTKView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupRenderer()
    }

    open func setupRenderer() {
        guard let mtkView = self.mtkView,
              let renderer = self.renderer else {
            return
        }
        renderer.mtkView = mtkView
        mtkView.delegate = renderer
    }

    open func setupView() {
        guard let mtkView = self.view as? MTKView else {
            print("View attached to ViewController is not an MTKView")
            return
        }
        guard let defaultDevice = MTLCreateSystemDefaultDevice() else {
            print("Metal is not supported on this device")
            return
        }
        mtkView.device = defaultDevice
        self.mtkView = mtkView
    }

}
