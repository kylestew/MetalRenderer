import Metal

open class Material {
    var prefix: String {
        var result = String(describing: type(of: self)).replacingOccurrences(of: "Material", with: "")
        if let bundleName = Bundle(for: type(of: self)).displayName,
           bundleName != result {
            result = result.replacingOccurrences(of: bundleName, with: "")
        }
        result = result.replacingOccurrences(of: ".", with: "")
        return result
    }

    public lazy var label: String = {
        prefix
    }()

    public var shader: Shader?

    public var pipeline: MTLRenderPipelineState? {
        return shader?.pipeline
    }

    public var context: Context? {
        didSet {
            if context != nil, context != oldValue {
                setup()
            }
        }
    }

    public required init() {}

    public init(shader: Shader) {
//        self.label = shader.label
        self.shader = shader
    }

    open func setup() {
        setupShader()
    }

    open func setupShader() {
        if let context = context {
            if shader == nil {
                self.shader = SourceShader(label,
                                           getPipelinesMaterialsUrl(label)!.appendingPathComponent("Shaders.metal"))
            }

            if let shader = shader {
                shader.context = context
            }
        }
    }

}
