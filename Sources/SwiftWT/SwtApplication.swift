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


@MainActor
public class SwtApp {
    static var shared: SwtApp?
    internal var mainWidgets: [SwtCoreWindow] = []
    
    internal init() {}

    deinit {
        print("Cleanup SDL resources")
        SDL_QuitSubSystem(SDL_INIT_VIDEO | SDL_INIT_EVENTS)
        SDL_Quit()
    }

    public static func get() throws -> SwtApp {
        if shared == nil {
            // Initialise SDL
            if SDL_InitSubSystem(SDL_InitFlags(SDL_INIT_VIDEO | SDL_INIT_EVENTS)) == false {
                throw SwtAppError.FailedToInitialize("Couldn't initialise App: \(String(cString: SDL_GetError()))")
            }
            shared = SwtApp()
            shared?.setMetadata()
        }
        guard let sharedApp = shared else {
            throw SwtAppError.FailedToInitialize("Shared instance is nil")
        }
        return sharedApp
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

    public func run() -> Int32 {
        return 1
        // SDL_CreateSoftwareRenderer(UnsafeMutablePointer<SDL_Surface>!)
    }
}