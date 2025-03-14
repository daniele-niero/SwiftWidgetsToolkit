public class SwtStyle {
    func drawControl() {
        // draw the control
    }
}


// Painter protocol that act upon SwtObjects
@MainActor
public protocol SwtPaintable {
    var style: SwtStyle { get set }
    func render(_ painter: SwtPainter)
    func paint(painter: SwtPainter)
}

public extension SwtPaintable where Self: SwtObject {
    func render(_ painter: SwtPainter) {
        self.style.drawControl()
    }

    func paint(painter: SwtPainter) {
        self.render(painter)
        for child in self.children {
            // If the child is paintable, let it paint.
            (child as? SwtPaintable)?.paint(painter: painter)
        }
    }
}

// specialized painter for SwtObjects
public class SwtPainter {
}

