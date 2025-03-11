import Foundation

@MainActor
public class SwtWidget: SwtObject {
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
