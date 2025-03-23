/**
  The flags on a window that represent the same SDL3's SDL_WindowFlags
  
  These cover a lot of true/false, or on/off, window state. Some of it is
  immutable after being set through SDL_CreateWindow(), some of it can be
  changed on existing windows by the app, and some of it might be altered by
  the user or system outside of the app's control.
 */
public struct WindowFlags: OptionSet, Sendable {
    public let rawValue: UInt64

    public init(rawValue: UInt64) {
        self.rawValue = rawValue
    }

    /// window is in fullscreen mode
    static let fullscreen           = WindowFlags(rawValue: 0x0000000000000001)    
    /// window usable with OpenGL context
    static let opengl               = WindowFlags(rawValue: 0x0000000000000002)    
    /// window is occluded
    static let occluded             = WindowFlags(rawValue: 0x0000000000000004)    
    /// window is neither mapped onto the desktop nor shown in the taskbar/dock/window list; SDL_ShowWindow() is required for it to become visible
    static let hidden               = WindowFlags(rawValue: 0x0000000000000008)    
    /// no window decoration
    static let borderless           = WindowFlags(rawValue: 0x0000000000000010)    
    /// window can be resized
    static let resizable            = WindowFlags(rawValue: 0x0000000000000020)    
    /// window is minimized
    static let minimized            = WindowFlags(rawValue: 0x0000000000000040)    
    /// window is maximized
    static let maximized            = WindowFlags(rawValue: 0x0000000000000080)    
    /// window has grabbed mouse input
    static let mouseGrabbed         = WindowFlags(rawValue: 0x0000000000000100)    
    /// window has input focus
    static let inputFocus           = WindowFlags(rawValue: 0x0000000000000200)    
    /// window has mouse focus
    static let mouseFocus           = WindowFlags(rawValue: 0x0000000000000400)    
    /// window not created by SDL
    static let external             = WindowFlags(rawValue: 0x0000000000000800)    
    /// window is modal
    static let modal                = WindowFlags(rawValue: 0x0000000000001000)    
    /// window uses high pixel density back buffer if possible
    static let highPixelDensity     = WindowFlags(rawValue: 0x0000000000002000)    
    /// window has mouse captured (unrelated to MOUSE_GRABBED)
    static let mouseCapture         = WindowFlags(rawValue: 0x0000000000004000)    
    /// window has relative mode enabled
    static let mouseRelativeMode    = WindowFlags(rawValue: 0x0000000000008000)    
    /// window should always be above others
    static let alwaysOnTop          = WindowFlags(rawValue: 0x0000000000010000)    
    /// window should be treated as a utility window, not showing in the task bar and window list
    static let utility              = WindowFlags(rawValue: 0x0000000000020000)    
    /// window should be treated as a tooltip and does not get mouse or keyboard focus, requires a parent window
    static let tooltip              = WindowFlags(rawValue: 0x0000000000040000)    
    /// window should be treated as a popup menu, requires a parent window
    static let popupMenu            = WindowFlags(rawValue: 0x0000000000080000)    
    /// window has grabbed keyboard input
    static let keyboardGrabbed      = WindowFlags(rawValue: 0x0000000000100000)    
    /// window usable for Vulkan surface
    static let vulkan               = WindowFlags(rawValue: 0x0000000010000000)    
    /// window usable for Metal view
    static let metal                = WindowFlags(rawValue: 0x0000000020000000)    
    /// window with transparent buffer
    static let transparent          = WindowFlags(rawValue: 0x0000000040000000)    
    /// window should not be focusable
    static let notFocusable         = WindowFlags(rawValue: 0x0000000080000000)    

}
