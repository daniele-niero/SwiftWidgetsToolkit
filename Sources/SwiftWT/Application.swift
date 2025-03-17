import SDL3

// Application Errors
enum SwtAppError: Error {
    case FailedToInitialize(String)
    case FailedToRun(String)
    case MetadataError(String)
}

/// Map to SDL metadata properties
public enum EAppMetadataProperties: String {
    case name         = "SDL.app.metadata.name"
    case version      = "SDL.app.metadata.version"
    case identifier   = "SDL.app.metadata.identifier"
    case creator      = "SDL.app.metadata.creator"
    case copyright    = "SDL.app.metadata.copyright"
    case url          = "SDL.app.metadata.url"
    case type         = "SDL.app.metadata.type"
}

public enum EAppResult: Int32 {
    case  success   = 0
    case  failure   = 1
    case `continue` = 2
}


@MainActor
public class SwtApp {
    private static var shared: SwtApp?
    internal var mainWindows: [SwtWindow] = []
    internal var allEventReceivers: [WeakEventReceiver] = []
    private var running = false
    
    internal init() {}

    deinit {
        print("Cleanup SDL resources")
        SDL_QuitSubSystem(SDL_INIT_VIDEO | SDL_INIT_EVENTS)
        SDL_Quit()
    }

    public static func get() throws -> SwtApp {
        guard let shared = shared else {
            // Initialise SDL
            if SDL_InitSubSystem(SDL_InitFlags(SDL_INIT_VIDEO | SDL_INIT_EVENTS)) == false {
                throw SwtAppError.FailedToInitialize("Couldn't initialise App: \(String(cString: SDL_GetError()))")
            }
            shared = SwtApp()
            shared?.setMetadata()
            return shared!
        }
        return shared
    }

    public func setMetadata(name: String       = "SwtWidget App", 
                            version: String    = "1.0", 
                            identifier: String = "com.default.app",
                            creator: String?   = nil,
                            copyright: String? = nil,
                            url: String?       = nil,
                            type: String?      = nil) {
        self.setMetadataProperty(EAppMetadataProperties.name, value: name)
        self.setMetadataProperty(EAppMetadataProperties.version, value: version)
        self.setMetadataProperty(EAppMetadataProperties.identifier, value: identifier)
        
        if creator != nil {self.setMetadataProperty(EAppMetadataProperties.creator, value: creator!)}
        if copyright != nil {self.setMetadataProperty(EAppMetadataProperties.copyright, value: copyright!)}
        if url != nil {self.setMetadataProperty(EAppMetadataProperties.url, value: url!)}
        if type != nil {self.setMetadataProperty(EAppMetadataProperties.type, value: type!)}
    }

    public func getMetadataProperty(_ property: EAppMetadataProperties) -> String? {
        guard let propertyPointer = SDL_GetAppMetadataProperty(property.rawValue) else {
            print("Error: \(String(cString: SDL_GetError()))", asError: true)
            return nil
        }
        return String(cString: propertyPointer)
    }

    public func setMetadataProperty(_ property: EAppMetadataProperties, value: String) {
        if SDL_SetAppMetadataProperty(property.rawValue, value) == false {
            print("Error: \(String(cString: SDL_GetError()))", asError: true)
        }
    }

    public func run() -> EAppResult {
        running = true
        var sdlEvent = SDL_Event()
        while running {
            while SDL_PollEvent(&sdlEvent) {
                // // wrap the underling SDL's event into a Swt's event
                // let swtEvent = SwtEvent(sdlEvent)
                // switch swtEvent {
                //     case .quit:
                //         quit()
                //         break
                //     case .focusGained(let event), .focusLost(let event):
                //         for window in mainWindows {
                //             if window.windowID == event.windowID {
                //                 window.dispatchEvent(event)
                //             }
                //         }
                //     default:
                //         continue  // TODO: Handle this better
                // }

                // Poll events (non-blocking or with a timeout as needed)

                let sdlEventType = SDL_EventType(Int32(sdlEvent.type))
                switch sdlEventType {

                    case SDL_EVENT_QUIT:
                        quit()
                        break
                        
                    case SDL_EVENT_WINDOW_FOCUS_GAINED:
                        for window in mainWindows {
                            if window.windowID == sdlEvent.window.windowID {
                                sendEvent(SwtEvent(sdlEvent), to: window)
                            } 
                        }

                    case SDL_EVENT_WINDOW_FOCUS_LOST:
                        for window in mainWindows {
                            if window.windowID == sdlEvent.window.windowID {
                                sendEvent(SwtEvent(sdlEvent), to: window)
                            } 
                        }

                    default:
                        continue
                }
            }
            // Insert a delay if necessary (e.g. for frame limiting)
            SDL_Delay(16)
        }
        
        // Cleanup happens in deinit.
        return EAppResult.success
    }
    
    public func quit() {
        running = false
    }
}
