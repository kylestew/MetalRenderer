import Foundation

public func injectConstants(source: inout String) {
    source = source.replacingOccurrences(of: "// inject constants\n", with: (ConstantsSource.get() ?? "\n") + "\n")
}

public func injectVertex(source: inout String) {
    source = source.replacingOccurrences(of: "// inject vertex\n", with:
                                            (VertexSource.get() ?? "\n") + "\n")
}

public func injectVertexData(source: inout String) {
    source = source.replacingOccurrences(of: "// inject vertex data\n", with: (VertexDataSource.get() ?? "\n") + "\n")
}

public func injectVertexUniforms(source: inout String) {
    source = source.replacingOccurrences(of: "// inject vertex uniforms\n", with: (VertexUniformsSource.get() ?? "\n") + "\n")
}


class ConstantsSource {
    static let shared = ConstantsSource()
    private static var sharedSource: String?

    class func get() -> String? {
        guard ConstantsSource.sharedSource == nil else {
            return sharedSource
        }
        if let url = getPipelinesVelourUrl("Constants.metal") {
            do {
                sharedSource = try MetalFileCompiler().parse(url)
            } catch {
                print(error)
            }
        }
        return sharedSource
    }
}

class VertexSource {
    static let shared = VertexSource()
    private static var sharedSource: String?

    class func get() -> String? {
        guard VertexSource.sharedSource == nil else {
            return sharedSource
        }
        if let url = getPipelinesVelourUrl("Vertex.metal") {
            do {
                sharedSource = try MetalFileCompiler().parse(url)
            } catch {
                print(error)
            }
        }
        return sharedSource
    }
}

class VertexDataSource {
    static let shared = VertexDataSource()
    private static var sharedSource: String?

    class func get() -> String? {
        guard VertexDataSource.sharedSource == nil else {
            return sharedSource
        }
        if let url = getPipelinesVelourUrl("VertexData.metal") {
            do {
                sharedSource = try MetalFileCompiler().parse(url)
            }
            catch {
                print(error)
            }
        }
        return sharedSource
    }
}

class VertexUniformsSource {
    static let shared = VertexUniformsSource()
    private static var sharedSource: String?

    class func get() -> String? {
        guard VertexUniformsSource.sharedSource == nil else {
            return sharedSource
        }
        if let url = getPipelinesVelourUrl("VertexUniforms.metal") {
            do {
                sharedSource = try MetalFileCompiler().parse(url)
            }
            catch {
                print(error)
            }
        }
        return sharedSource
    }
}

