
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
public class SwtWindow: SwtObject, SwtEventReceiver {
    // Local variables to receive the window and renderer pointers.
    private var windowResource: SDLResource?
    private var rendererResource: SDLResource?
    internal var _windowId: UInt32
    public private(set) var active: Bool = false

    public override var parent : SwtObject? {
        get { return nil }
        set {}
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

    public var windowID: UInt32 {
        return SDL_GetWindowID(windowResource?.rawPointer)
    }

    public init(_ title: String, flags: WindowFlags? = nil) {
        let flags = flags ?? [.resizable]
        _windowId = 0
        super.init()
        
        createSdlWindowAndRenderer(title, x: 640, y: 480, flags: flags)
        _windowId = SDL_GetWindowID(windowResource?.rawPointer)

        do {
            let app = try SwtApp.get()
            // Register itself with the app.
            app.addMainWindow(self)
        } catch {
            print("Failed to get app: \(error)", asError: true)
            return
        }
    }

    /// Creates a new SDL3 window.
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

    /// Sets the opacity of the window.
    private func setWindowOpacity(_ opacity: Float) {
        guard let window = windowResource?.rawPointer else {
            print("Window is nil", asError: true)
            return
        }
        if SDL_SetWindowOpacity(window, opacity) == false {
            print("Failed to set window opacity: \(String(cString: SDL_GetError()))", asError: true)
        }
    }

    // MARK: - Events Handlers Implementation

    public func focusGainedEvent(_ event: SwtFocusEvent) { 
        active = true
        print("event gained, active: \(active)")
    }

    public func focusLostEvent(_ event: SwtFocusEvent) {
        active = false
        print("event lost: active: \(active)")
    }

    public func paintEvent(_ event: SwtPaintEvent) {
        for child in children {
            (child as? SwtEventReceiver)?.paintEvent(event)
        }

        event.painter.present()
    }

    func dispatchLowLevelEvent(_ sdlEvent: SDL_Event) {
        let type = SDL_EventType(Int32(sdlEvent.type))
        
        var eventType: SwtEvent
        switch type {
            case SDL_EVENT_QUIT:
                eventType = .quit
            case SDL_EVENT_WINDOW_FOCUS_GAINED:
                eventType = .focusGained(SwtFocusEvent(gainedFocus: true))
            case SDL_EVENT_WINDOW_FOCUS_LOST:
                eventType = .focusLost(SwtFocusEvent(gainedFocus: false))
            case SDL_EVENT_KEY_DOWN:
                eventType = .keyPressed(SwtKeyEvent(event: sdlEvent.key))
            case SDL_EVENT_KEY_UP:
                eventType = .keyReleased(SwtKeyEvent(event: sdlEvent.key))
            case SDL_EVENT_WINDOW_MOVED: //, SDL_EVENT_WINDOW_MINIMIZED, SDL_EVENT_WINDOW_MAXIMIZED:
                eventType = .paint(SwtPaintEvent(self.rendererResource!))
            default:
                eventType = .unknown
        }

        dispatchEvent(eventType, to: self)
    }
}