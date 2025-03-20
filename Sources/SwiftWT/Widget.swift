import Foundation

@MainActor
public class SwtWidget: SwtObject, /*SwtPaintable,*/ SwtEventReceiver {
    // internal var _style: SwtStyle? 
    // public var style: SwtStyle {
    //     get {
    //         // return style if exists, otherwise return paren style
    //         return _style ?? (parent as? SwtPaintable)?.style ?? SwtStyle()
    //     }
    //     set {
    //         _style = newValue
    //     }
    // }   

    public func show() {
        if parent == nil {
            // we need a window to host the widget
            let window = SwtWindow("SwiftWT")
            parent = window
        }
    }

    public func hide() {
        
    }

    // MARK: - SwtEventReceiver
    
    public func paintEvent(_ event: SwtPaintEvent) {
        print("Widget paint requested")
    }
}
