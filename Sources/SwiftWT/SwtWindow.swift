import SDL3


internal final class SDLResource: @unchecked Sendable {
    private var pointer: OpaquePointer?
    private let destroyClosure: (OpaquePointer) -> Void

    /// Initializes the resource wrapper with a C pointer and its corresponding destroy function.
    init(pointer: OpaquePointer, destroy: @escaping (OpaquePointer) -> Void) {
        self.pointer = pointer
        self.destroyClosure = destroy
    }
    
    /// Accessor to get the underlying pointer.
    var rawPointer: OpaquePointer? {
        return pointer
    }
    
    /// Manually destroy the resource if needed.
    func destroy() {
        if let ptr = pointer {
            destroyClosure(ptr)
            pointer = nil
        }
    }
    
    deinit {
        destroy()
    }
}


/// A Swift class to manage an SDL3 window.
@MainActor
public class SwtCoreWindow {
    // Local variables to receive the window and renderer pointers.
    private var windowResource: SDLResource?
    private var rendererResource: SDLResource?

    /// Creates a new SDL3 window.
    /// - Parameters:
    ///   - flags: SDL window flags (default is 0).
    ///   - parent: The title of the window.
    public init(_ title: String, x: Int32 = 640, y: Int32 = 480, flags: WindowFlags? = nil) {
        let flags = flags ?? WindowFlags()

        var cWindowPtr: OpaquePointer?
        var cRendererPtr: OpaquePointer?

        // Create window and renderer in one call.
        if SDL_CreateWindowAndRenderer(title, x, y, flags.rawValue, &cWindowPtr, &cRendererPtr) == false {
            print("Couldn't create window/renderer: \(String(cString: SDL_GetError()))", asError: true)
        }

        // Make sure the pointers are valid.
        guard let validWindowPtr = cWindowPtr,
            let validRendererPtr = cRendererPtr else {
            print("Received nil pointer from SDL_CreateWindowAndRenderer", asError: true)
            return
        }
        
        // Wrap the pointers in SDLResource, providing the appropriate destroy functions.
        windowResource = SDLResource(pointer: validWindowPtr, destroy: SDL_DestroyWindow)
        rendererResource = SDLResource(pointer: validRendererPtr, destroy: SDL_DestroyRenderer)
    }
}
