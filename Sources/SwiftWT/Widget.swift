import Foundation

@MainActor
open class SwtWidget: SwtObject, /*SwtPaintable,*/ SwtEventReceiver {
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
        event.painter.save()
        event.painter.drawColor = SwtColor(r: 255, g: 0, b: 0)
        event.painter.fillColor = SwtColor(r: 0, g: 255, b: 0, a: 155)
        event.painter.fillRect(x: 0, y: 0, width: 100, height: 100)
        event.painter.drawRect(x: 0, y: 0, width: 100, height: 100)
        event.painter.restore()
    }
}
