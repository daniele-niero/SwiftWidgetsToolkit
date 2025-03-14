import SDL3

// MARK: - Swt Event Wrappers around SDL's events

/// A Swift enum wrapping a subset of SDL events.
public enum SwtEvent {
    case unknown
    case keyPressed(SwtKeyEvent)
    case keyReleased(SwtKeyEvent)
    // case mouseMotion(SwtMouseMotionEvent)
    // Add other cases as needed.

    /// Converts a raw SDL_Event into a Swift-friendly SwtEvent.
    internal init(_ sdlEvent: SDL_Event) {
        // SDL_Event.type is a UInt32, but our SDL_EVENT_* constants are Int32.
        let type = SDL_EventType(Int32(sdlEvent.type))
        
        switch type {
        case SDL_EVENT_KEY_DOWN:
            self = .keyPressed(SwtKeyEvent(event: sdlEvent.key))
        case SDL_EVENT_KEY_UP:
            self = .keyReleased(SwtKeyEvent(event: sdlEvent.key))
        // Uncomment and add more cases as needed:
        // case SDL_EVENT_MOUSE_MOTION:
        //     let motion = sdlEvent.motion
        //     let mouseMotion = SwtMouseMotionEvent(x: motion.x,
        //                                           y: motion.y,
        //                                           xRel: motion.xrel,
        //                                           yRel: motion.yrel)
        //     self = .mouseMotion(mouseMotion)
        default:
            self = .unknown
        }
    }
}



