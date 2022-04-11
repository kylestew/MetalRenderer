import Metal

open class Shader {

    var pipelineOptions: MTLPipelineOption {
        [.argumentInfo, .bufferTypeInfo]
    }

    public internal(set) var pipelineReflection: MTLRenderPipelineReflection?
    public internal(set) var pipeline: MTLRenderPipelineState?
    public internal(set) var library: MTLLibrary?
    var libraryURL: URL?

    public var label: String = "Shader"
    public var vertexFunctionName: String = "shaderVertex"
    public var fragmentFunctionName: String = "shaderFragment"

    public var vertexDescriptor: MTLVertexDescriptor = StandardVertexDescriptor()

    var context: Context? {
        didSet {
            if oldValue != context {
                setup()
            }
        }
    }

    public init(_ label: String,
                _ vertexFunctionName: String? = nil,
                _ fragmentFunctionName: String? = nil,
                _ libraryURL: URL? = nil
    ) {
        self.label = label

        self.vertexFunctionName = vertexFunctionName ?? label.camelCase + "Vertex"
        self.fragmentFunctionName = fragmentFunctionName ?? label.camelCase + "Fragment"
        self.libraryURL = libraryURL
    }

    func setup() {
        setupLibrary()
        setupPipeline()
    }

    func setupLibrary() {
        guard let context = context else { return }
        do {
            var library: MTLLibrary?
            if let url = libraryURL {
                library = try context.device.makeLibrary(URL: url)
            } else {
                library = try context.device.makeDefaultLibrary(bundle: Bundle.main)
            }
            self.library = library
        }
        catch {
            print("\(label) Shader: \(error.localizedDescription)")
        }
    }

    func setupPipeline() {
        guard let context = context,
              let library = library else {
            return
        }

        do {
            guard let vertexProgram = library.makeFunction(name: vertexFunctionName),
                  let fragmentProgram = library.makeFunction(name: fragmentFunctionName) else {
                return
            }

            let device = library.device
            let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
            pipelineStateDescriptor.label = label
            pipelineStateDescriptor.vertexFunction = vertexProgram
            pipelineStateDescriptor.fragmentFunction = fragmentProgram
            pipelineStateDescriptor.sampleCount = context.sampleCount
            pipelineStateDescriptor.vertexDescriptor = vertexDescriptor
            pipelineStateDescriptor.colorAttachments[0].pixelFormat = context.colorPixelFormat

            pipeline = try device.makeRenderPipelineState(descriptor: pipelineStateDescriptor,
                                                          options: pipelineOptions,
                                                          reflection: &pipelineReflection)

        } catch {
            print("\(label) Shader: \(error.localizedDescription)")
        }
    }

}
