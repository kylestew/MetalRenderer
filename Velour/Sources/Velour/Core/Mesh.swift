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

}
