import Foundation

@MainActor
public class SwtWidget: SwtObject, /*SwtPaintable,*/ SwtEventReceiver {
    private var window: SwtWindow? = nil

    public func show() {
        if parent == nil || window == nil {
            // we need a window to host the widget
            window = SwtWindow("SwiftWT")
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
