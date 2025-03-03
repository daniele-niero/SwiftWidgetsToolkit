
/// A class representing an object in the Swift Widget Toolkit (SWT) hierarchy.
/// Each `SwtObject` can have a parent and multiple children, forming a tree structure.
public class SwtObject {

    /// The parent of this object. It is a weak reference to avoid retain cycles.
    private weak var _parent: SwtObject?
    
    /// The children of this object.
    private var _children: [SwtObject] = []
    
    /// Initializes a new `SwtObject` with an optional parent.
    /// - Parameter: parent: The parent of this object. 
    ///                      If provided, this object will be added to the parent's children.
    public init(parent: SwtObject? = nil) {
        if (parent != nil) {
            self.parent = parent
        }
    }

    public var parent : SwtObject? {
        get {
            return _parent
        }
        set {
            guard _parent !== newValue else { return }
            if _parent != nil {
                _parent!.removeChild(self)
            }
            if newValue != nil {
                newValue!.addChild(self)
            }
            _parent = newValue
        }
    }

    public var children: [SwtObject] {
        return _children
    }
    

    /// Adds a child to this object.
    /// Note: This function doesn't add the parent to the child's parent property.
    ///       Being a private function, it is only called when the parent is already set or being set.
    ///       This avoids loops twhere the parent is set on the child and the child is set on the parent.
    /// - Parameter child: The child to be added.
    private func addChild(_ child: SwtObject) {
        if _children.contains(where: { $0 === child }) {
            return
        }
        _children.append(child)
    }
    
    /// Removes a child from this object.
    /// - Parameter child: The child to be removed.
    public func removeChild(_ child: SwtObject) {
        _children.removeAll { $0 === child }
        child._parent = nil
    }
}