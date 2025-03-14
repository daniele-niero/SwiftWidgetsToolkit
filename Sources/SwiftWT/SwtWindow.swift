
import SDL3

internal final class SDLResource: @unchecked Sendable {
    private var pointer: OpaquePointer?
    private let destroyClosure: (OpaquePointer) -> Void

    /// Accessor to get the underlying pointer.
    var rawPointer: OpaquePointer? {
        return pointer
    }
    
    /// Initializes the resource wrapper with a C pointer and its corresponding destroy function.
    init(pointer: OpaquePointer, destroy: @escaping (OpaquePointer) -> Void) {
        self.pointer = pointer
        self.destroyClosure = destroy
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

public struct SwtSize {
    public var width: Int32
    public var height: Int32
}

@MainActor
public class SwtWindow: SwtEventReceiver, SwtObject {
    // Local variables to receive the window and renderer pointers.
    private var windowResource: SDLResource?
    private var rendererResource: SDLResource?

    public override var parent : SwtObject? {
        get {
            return nil
        }
        set {
        }
    }

    public var title: String {
        get {
            return String(cString: SDL_GetWindowTitle(windowResource?.rawPointer))
        }
        set {
            SDL_SetWindowTitle(windowResource?.rawPointer, newValue)
        }
    }

    public var size: SwtSize {
        get {
            var size = SwtSize(width: 0, height: 0)
            SDL_GetWindowSize(windowResource?.rawPointer, &size.width, &size.height)
            return size
        }
        set {
            SDL_SetWindowSize(windowResource?.rawPointer, newValue.width, newValue.height)
        }
    }

    /// Creates a new SDL3 window.
    /// - Parameters:
    ///   - flags: SDL window flags (default is 0).
    ///   - parent: The title of the window.
    private func createSdlWindowAndRenderer(_ title: String, x: Int32, y: Int32, flags: WindowFlags) {
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


    public init(_ title: String, flags: WindowFlags? = nil) {
        let flags = flags ?? [.resizable]
        super.init()

        createSdlWindowAndRenderer(title, x: 640, y: 480, flags: flags)

        do {
            let app = try SwtApp.get()
            // Register itself with the app.
            app.mainWindows.append(self)
        } catch {
            print("Failed to get app: \(error)", asError: true)
            return
        }
    }

    public fun event(_ event: SDL_Event) -> Bool {
        return
    }

    public func paint() {
        guard let renderer = rendererResource?.rawPointer else {
            print("Renderer is nil", asError: true)
            return
        }

        // Set the draw color to white.
        SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255)
        // Clear the window with the draw color.
        SDL_RenderClear(renderer)
        // Present the renderer.
        SDL_RenderPresent(renderer)

        let painter = SwtPainter()

        for child in children {
            (child as? SwtPaintable)?.paint(painter: painter)
        }
    }

    deinit {
    //     do {
    //         let app = try SwtApp.get()
    //         // Unregister itself from the app.
    //         app.mainWidgets.removeAll { $0 === self }
    //     } catch {
    //         print("Failed to get app: \(error)", asError: true)
    //     }
    }

}