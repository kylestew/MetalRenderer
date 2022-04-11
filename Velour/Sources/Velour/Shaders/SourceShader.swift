import Foundation

open class SourceShader: Shader {

    public var pipelineURL: URL

    public private(set) var source: String?
    public private(set) var shaderSource: String?

    public required init(_ label: String,
                         _ pipelineURL: URL,
                         _ vertexFunctionName: String? = nil,
                         _ fragmentFunctionName: String? = nil) {
        self.pipelineURL = pipelineURL
        super.init(label, vertexFunctionName, fragmentFunctionName)
        setupSource()
    }

    public required init() {
        fatalError("init() has not been implemented")
    }

    override func setup() {
        setupSource()
        super.setup()
    }

//    override func update() {
//    }

    override func setupLibrary() {
        guard let context = context,
              let source = source else {
            return
        }
        do {
            library = try context.device.makeLibrary(source: source, options: nil)
        } catch {
            print("\(label) Shader: \(error.localizedDescription)")
        }
    }

    func setupShaderSource() -> String? {
        do {
            return try MetalFileCompiler().parse(pipelineURL)
        } catch {
            print("\(label) Shader: \(error.localizedDescription)")
        }
        return nil
    }

    func setupSource() {
        guard let velourURL = getPipelinesVelourUrl(),
              let shaderSource = setupShaderSource() else {
            return
        }
        let includesURL = velourURL.appendingPathComponent("Includes.metal")
        do {
            let compiler = MetalFileCompiler()
            var source = try compiler.parse(includesURL)

            injectConstants(source: &source)
            injectVertex(source: &source)
            injectVertexData(source: &source)
            injectVertexUniforms(source: &source)

            source += shaderSource

            print(source)

            self.shaderSource = shaderSource
            self.source = source
        } catch {
            print("\(label) Shader: \(error.localizedDescription)")
        }
    }

}
