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
    struct RendererState {
        let drawColor: (UInt8, UInt8, UInt8, UInt8)
        let blendMode: SDL_BlendMode
    }

    private var renderer: SDLResource
    private var stateStack: [RendererState] = []

    internal init(_ renderer: SDLResource) {
        self.renderer = renderer
    }
    
    func save() {
        guard let renderer = self.renderer.rawPointer else { return }
        // Query current draw color
        var r: UInt8 = 0, g: UInt8 = 0, b: UInt8 = 0, a: UInt8 = 0
        SDL_GetRenderDrawColor(renderer, &r, &g, &b, &a)
        
        // Query current blend mode
        var blendMode = SDL_BlendMode(SDL_BLENDMODE_NONE)
        SDL_GetRenderDrawBlendMode(renderer, &blendMode)

        let state = RendererState(drawColor: (r, g, b, a), blendMode: blendMode)
        stateStack.append(state)
    }
    
    func restore() {
        guard let renderer = self.renderer.rawPointer else { return }

        guard let state = stateStack.popLast() else { return }
        
        // Restore draw color
        SDL_SetRenderDrawColor(renderer,
                               state.drawColor.0,
                               state.drawColor.1,
                               state.drawColor.2,
                               state.drawColor.3)
        // Restore blend mode
        SDL_SetRenderDrawBlendMode(renderer, state.blendMode)
    }

    public func setDrawColor(r: UInt8, g: UInt8, b: UInt8, a: UInt8) {
        guard let renderer = self.renderer.rawPointer else { return }
        SDL_SetRenderDrawColor(renderer, r, g, b, a)
    }

    public func present() {
        guard let renderer = self.renderer.rawPointer else { return }
        SDL_RenderPresent(renderer)
    }
    
    // Other drawing methods...

    public func drawRect(x: Int32, y: Int32, width: Int32, height: Int32) {
        guard let renderer = self.renderer.rawPointer else { return }

        var sdlRect = SDL_FRect(x: Float(x), y: Float(y), w: Float(width), h: Float(height))
        // Draw the rectangle outline
        SDL_RenderRect(renderer, &sdlRect)
    }
}

