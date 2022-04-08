import UIKit

open class ViewController: UIViewController {

    open var renderer: Renderer? {
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

    open func setupRenderer() {
    }

}
