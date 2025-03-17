import SDL3

// MARK: - Swt Event Wrappers around SDL's events


// List of things to implement
//   [ ]: Implement a way to find the target widget for an event.
//        For instance, Key events should go only to the Widget that has focus.
//        Mouse events should go to the Widget that is under the mouse.
//        Paint events should go to the Widget that needs to be repainted.
//   [ ]: Implement a way to propagate events up the widget hierarchy.
//   [ ]: Implement a way to stop event propagation.
//   [ ]: Implement a way for Widgets to register specific interest in receiving events. 
//        This should further reduce the number of events that need to be processed.
//   [ ]: Add more event types as needed.


/// A Swift enum wrapping a subset of SDL events.
public enum SwtEvent {
    case unknown
    case quit
    case focusGained(SwtFocusEvent)
    case focusLost(SwtFocusEvent)
    case keyPressed(SwtKeyEvent)
    case keyReleased(SwtKeyEvent)

    /// Converts a raw SDL_Event into a Swift-friendly SwtEvent.
    internal init(_ sdlEvent: SDL_Event) {
        // SDL_Event.type is a UInt32, but our SDL_EVENT_* constants are Int32.
        let type = SDL_EventType(Int32(sdlEvent.type))
        
        switch type {
            case SDL_EVENT_QUIT:
                self = .quit
            case SDL_EVENT_WINDOW_FOCUS_GAINED:
                self = .focusGained(SwtFocusEvent(gainedFocus: true))
            case SDL_EVENT_WINDOW_FOCUS_LOST:
                self = .focusLost(SwtFocusEvent(gainedFocus: false))
            case SDL_EVENT_KEY_DOWN:
                self = .keyPressed(SwtKeyEvent(event: sdlEvent.key))
            case SDL_EVENT_KEY_UP:
                self = .keyReleased(SwtKeyEvent(event: sdlEvent.key))
            default:
                self = .unknown
        }
    }
}

public class SwtEventBase {
    public var accepted: Bool = true
}

public class SwtFocusEvent: SwtEventBase {
    let _gainedFocus: Bool 

    init (gainedFocus: Bool) {
        _gainedFocus = gainedFocus
    }  

    public var gotFocus: Bool {
        return _gainedFocus
    }

    public var lostFocus: Bool {
        return !_gainedFocus
    }
}

@MainActor
public protocol SwtEventReceiver: AnyObject {
    func event(_ event: SwtEvent)
    func focusGainedEvent(_ event: SwtFocusEvent)
    func focusLostEvent(_ event: SwtFocusEvent)
    func keyEvent(_ event: SwtKeyEvent)
}

extension SwtEventReceiver where Self: SwtObject {
    public func event(_ event: SwtEvent) {}
    public func focusGainedEvent(_ event: SwtFocusEvent) { 
        print("AHHHH SHIT")
    }
    public func focusLostEvent(_ event: SwtFocusEvent) {
        print("DOUBLE SHIT")
    } 
    public func keyEvent(_ event: SwtKeyEvent) { }
    // public func paintEvent(_ event: SwtPaintEvent) -> Bool { return false }
}

@MainActor
public func sendEvent(_ eventType: SwtEvent, to receiver: SwtEventReceiver) {
    switch eventType {
        case .keyPressed(let event):
            receiver.keyEvent(event)
        case .keyReleased(let event):
            receiver.keyEvent(event)
        case .focusGained(let event):
            receiver.focusGainedEvent(event)
        case .focusLost(let event):
            receiver.focusLostEvent(event)
        default:
            receiver.event(eventType)
    } 
}


class WeakEventReceiver {
    weak var receiver: (any SwtEventReceiver)?

    init(receiver: any SwtEventReceiver) {
        self.receiver = receiver
    }
}