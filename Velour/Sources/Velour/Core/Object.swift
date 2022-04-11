import Foundation
import Combine

open class Object {

    open var label: String = "Object"

    open var visible: Bool = true

    open var context: Context? = nil {
        didSet {
            if context != nil, context != oldValue {
                setup()
                for child in children {
                    child.context = context
                }
            }
        }
    }

    open weak var parent: Object?
    open var children: [Object] = []

    public init() {}

    public init(_ label: String, _ children: [Object] = []) {
        self.label = label
        for child in children {
            add(child)
        }
    }

    open func setup() {}

    open func add(_ child: Object) {
        if !children.contains(where: { $0 === child }) {
            child.parent = self
            child.context = context // causes node to setup
            children.append(child)
        }
    }

}
