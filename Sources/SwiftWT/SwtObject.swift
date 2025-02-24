// An object that caan hold parent child relationships like Qt's QObject

public class SwtObject {
    private weak var parent: SwtObject?
    private var children: [SwtObject] = []
    
    public init(parent: SwtObject? = nil) {
        if (parent != nil) {
            parent!.addChild(self)
        }
    }
    
    private func addChild(_ child: SwtObject) {
        if children.contains(where: { $0 === child }) {
            return
        }
        children.append(child)
        child.parent = self
    }
    
    public func removeChild(_ child: SwtObject) {
        children.removeAll { $0 === child }
        child.parent = nil
    }
    
    public func removeAllChildren() {
        children.forEach { $0.parent = nil }
        children.removeAll()
    }
    
    public func removeFromParent() {
        parent?.removeChild(self)
    }
}