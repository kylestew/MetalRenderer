import SwiftUI

public struct HearthView: UIViewControllerRepresentable {

    public var renderer: Hearth.Renderer
    public typealias UIViewControllerType = Hearth.ViewController

    public init(renderer: Hearth.Renderer) {
        self.renderer = renderer
    }

    public func makeUIViewController(context: Context) -> UIViewControllerType {
        return Hearth.ViewController(renderer: renderer)
    }

    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }

//    public func makeCoordinator() -> () {
//    }

}

