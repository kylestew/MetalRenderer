import Metal

open class Mesh: Object {

    public var geometry = Geometry()
    public var material: Material?

    public init(geometry: Geometry, material: Material?) {
        super.init()
        self.geometry = geometry
        self.material = material
    }

    public required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }

    override open func setup() {
        setupGeometry()
        setupMaterial()
    }

    internal func setupGeometry() {
        guard let context = context else { return }
        geometry.context = context
    }

    internal func setupMaterial() {
        guard let context = context,
              let material = material else {
            return
        }
        material.context = context
    }

}
