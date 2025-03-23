import SDL3

// Painter protocol that act upon SwtObjects
@MainActor
public protocol SwtPaintable {
    // var style: SwtStyle { get set }
    func render(_ painter: SwtPainter)
    func paint(painter: SwtPainter)
}

// public extension SwtPaintable where Self: SwtObject {
//     func render(_ painter: SwtPainter) {
//         self.style.drawControl()
//     }

//     func paint(painter: SwtPainter) {
//         self.render(painter)
//         for child in self.children {
//             // If the child is paintable, let it paint.
//             (child as? SwtPaintable)?.paint(painter: painter)
//         }
//     }
// }


public final class SwtPainter {
    struct State {
        let drawColor: SwtColor
        let fillColor: SwtColor
        let blendMode: SDL_BlendMode
    }

    private var renderer: SDLResource
    private var stateStack: [State] = []
    public var drawColor: SwtColor = .white
    public var fillColor: SwtColor = .black

    internal init(_ renderer: SDLResource) {
        self.renderer = renderer
    }

    private static func setColor(_ renderer: OpaquePointer!, _ color: SwtColor) {
        SDL_SetRenderDrawColor(renderer, color.red, color.green, color.blue, color.alpha)
    }
    
    func save() {
        guard let renderer = self.renderer.rawPointer else { return }
        
        // Query current blend mode
        var blendMode = SDL_BlendMode(SDL_BLENDMODE_NONE)
        SDL_GetRenderDrawBlendMode(renderer, &blendMode)

        let state = State(drawColor: drawColor, fillColor: fillColor, blendMode: blendMode)
        stateStack.append(state)
    }
    
    func restore() {
        guard let renderer = self.renderer.rawPointer else { return }

        guard let state = stateStack.popLast() else { return }
        self.drawColor = state.drawColor
        self.fillColor = state.fillColor

        SwtPainter.setColor(renderer, drawColor)
        
        // Restore blend mode
        SDL_SetRenderDrawBlendMode(renderer, state.blendMode)
    }

    public func clear() {
        guard let renderer = self.renderer.rawPointer else { return }
        SwtPainter.setColor(renderer, fillColor)
        SDL_RenderClear(renderer)
    }

    public func present() {
        guard let renderer = self.renderer.rawPointer else { return }
        SDL_RenderPresent(renderer)
    }
    
    // Other drawing methods...

    public func drawRect(x: Int32, y: Int32, width: Int32, height: Int32) {
        guard let renderer = self.renderer.rawPointer else { return }

        SwtPainter.setColor(renderer, drawColor)

        var sdlRect = SDL_FRect(x: Float(x), y: Float(y), w: Float(width), h: Float(height))
        // Draw the rectangle outline
        SDL_RenderRect(renderer, &sdlRect)
    }

    public func fillRect(x: Int32, y: Int32, width: Int32, height: Int32) {
        guard let renderer = self.renderer.rawPointer else { return }

        SwtPainter.setColor(renderer, fillColor)

        var sdlRect = SDL_FRect(x: Float(x), y: Float(y), w: Float(width), h: Float(height))
        // Draw the rectangle outline
        SDL_RenderFillRect(renderer, &sdlRect)
    }
}

