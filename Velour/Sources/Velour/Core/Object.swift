import Foundation
import Combine

open class Object: Codable {

    open var label: String = "Object"

    public init(_ label: String, _ children: [Object] = []) {
        self.label = label
        for child in children {
            add(child)
        }
    }

    open func add(_ child: Object) {
    }

}
