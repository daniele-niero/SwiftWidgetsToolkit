import Foundation

@MainActor
public class SwtWidget: SwtObject, SwtPaintable {
    internal var _style: SwtStyle? 
    public var style: SwtStyle {
        get {
            // return style if exists, otherwise return paretn style
            return _style ?? (parent as? SwtPaintable)?.style ?? SwtStyle()
        }
        set {
            _style = newValue
        }
    }   

    public func show() {
        if parent == nil {
            // we need a window to host the widget
            let window = SwtWindow("SwiftWT Widget")
            parent = window
        }
    }

    public func hide() {
        
    }
}
