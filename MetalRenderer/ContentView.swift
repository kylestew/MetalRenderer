import SwiftUI
import MetalKit

import Hearth
import Velour

// Subclass Forge's Renderer to get triple buffered rendering and
// callbacks for Setup, Update, Draw, Resize and Events
class SimpleRenderer: Hearth.Renderer {

    // A Context contains important information that is needed to help compile shaders
    // and ensure we are drawing with the right color and depth pixel formats and sample count
    var context: Context!

    // A Satin Renderer handles setting the Content on all the objects in the scene graph
    // and drawing the scene either to a texture or on screen
    var renderer: Velour.Renderer!

    // A PerspectiveCamera is used to render the scene using perspective projection
    // All Satin Cameras inherit from Object, so it has
//    var camera: PerspectiveCamera!

    // An Object is just an empty node in Satin's Scene Graph, it can have children and a parent
    // Objects have a position, orientation, scale and label
    var scene: Object = Object("Scene")

    // Meshes inherit from Object, so they have all the properties an object has.
    // A Mesh has unique properties like geometry, material and rendering properties
    // To create renderable object aka a Mesh, you pass it a Geometry and Material like so
//    var boxMesh = Mesh(geometry: BoxGeometry(size: 1.0), material: BasicDiffuseMaterial(0.75))

    // Create a time variable so we can change things in our scene over time
//    var time: Float = 0.0

    // Forge calls setup once after it has a valid MTKView (mtkView)
    override func setup() {
        // Forge's Renderer class provides a MTLDevice and convenience getters for the view's color pixel format,
        // depth pixel format and stencil pixel format, by default a Forge Renderer has depth
        context = Context(device, sampleCount, colorPixelFormat, depthPixelFormat, stencilPixelFormat)

        // When creating a camera, you can specify an initial position and the near and far plane values
//        camera = PerspectiveCamera(position: [0.0, 0.0, 5.0], near: 0.01, far: 100.0)

        // Create a Satin Renderer by passing in a context, scene and camera
//        renderer = Satin.Renderer(context: context, scene: scene, camera: camera)
        renderer = Velour.Renderer(context: context)
        // There are many properties you can set on the renderer, this is how to clear to white
//        renderer.setClearColor([1, 1, 1, 1])

        // Finally add the box mesh created above to the scene
//        scene.add(boxMesh)
    }

    // Forge calls update whenever a new frame is ready to be updated, make scene changes here
    override func update() {
        // We increment our time variable so we can procedurally set the box mesh's orientation and material color
//        time += 0.05
//        let sx = sin(time)
//        let sy = cos(time)

        // Setting a material property done by using the set function, this modifies the material's uniforms
//        boxMesh.material?.set("Color", [abs(sx), abs(sy), abs(sx + sy), 1.0])
//
//        // You can manually an object's position, orientation, scale, and localMatrix. Here I'm using a
//        // convenience lookAt function to orient the box to face the point passed from its current position
//        boxMesh.lookAt([sx, sy, 2.0])
    }

    // Forge calls draw when a new frame is ready to be encoded for drawing
    override func draw(_ view: MTKView, _ commandBuffer: MTLCommandBuffer) {
        guard let renderPassDescriptor = view.currentRenderPassDescriptor else { return }

        // To render a scene into a render pass, just call draw and pass in the render pass descriptor
        // You can also specify a render target and render to a texture instead
        renderer.draw(renderPassDescriptor: renderPassDescriptor, commandBuffer: commandBuffer)
    }

    // Forge calls resize whenever the view is resized
    override func resize(_ size: (width: Float, height: Float)) {
//        // whenever the screen is resized we need to make sure:
//
//        // our camera's aspect ratio is set
//        camera.aspect = size.width / size.height
//
//        // our renderer's viewport & texture sizes are set
//        renderer.resize(size)
//        // if you need to render to a custom viewport, you can specify that after the resize call:
//        // renderer.viewport = MTLViewport(...)
    }
}

struct ContentView: View {
    var body: some View {
        HearthView(renderer: SimpleRenderer())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
