import SDL3


// Application Errors
enum SwtAppError: Error {
    case FailedToInitialise(String)
    case FailedToRun(String)
    case MetadataError(String)
}


// A struct that holds the metadata of an App
public struct SwtAppMetadata: Sendable {
    let name: String
    let version: String
    let identifier: String

    static let `default` = SwtAppMetadata(name: "SwtWidget App", version: "1.0", identifier: "com.default.app")

    // properties
    enum EProperties: String {
        case name         = "SDL.app.metadata.name"
        case version      = "SDL.app.metadata.version"
        case identifier   = "SDL.app.metadata.identifier"
        case creator      = "SDL.app.metadata.creator"
        case copyright    = "SDL.app.metadata.copyright"
        case url          = "SDL.app.metadata.url"
        case type         = "SDL.app.metadata.type"
    }
}


@MainActor
public class SwtApp {
    static let shared: SwtApp?
    private var mainWidgets: [SwtWidget] = []

    enum SwtAppError: Error {
        case InitializationFailed(String)
    }
    
    internal init() {}

    public static func get() throws -> SwtApp {
        if shared == nil {
            // Initialise SDL
            if SDL_InitSubSystem(SDL_InitFlags(SDL_INIT_VIDEO | SDL_INIT_EVENTS)) == false {
                throw SwtAppError.FailedToInitialise("Couldn't initialise App: \(String(cString: SDL_GetError()))")
            }
            shared = SwtApp()
            shared?.setMetadata(SwtAppMetadata.default)
        }
        guard let sharedApp = shared else {
            throw SwtAppError.FailedToInitialise("Shared instance is nil")
        }
        return sharedApp
    }

    public func setMetadata(_ metadata: SwtAppMetadata) {
        // Todo: 
        // * Maybe we should set a more rich SDL_SetAppMetadataProperty
        SDL_SetAppMetadata(metadata.name, metadata.version, metadata.identifier)
    }

    public func getMetadata() -> SwtAppMetadata? {
        guard 
            let namePointer = SDL_GetAppMetadataProperty(SwtAppMetadata.EProperties.name.rawValue),
            let versionPointer = SDL_GetAppMetadataProperty(SwtAppMetadata.EProperties.version.rawValue),
            let identifierPointer = SDL_GetAppMetadataProperty(SwtAppMetadata.EProperties.identifier.rawValue)
        else {
            print("Error: \(String(cString: SDL_GetError()))", asError: true)
            return nil
        }
        let name = String(cString: namePointer)
        let version = String(cString: versionPointer)
        let identifier = String(cString: identifierPointer)
        return SwtAppMetadata(name: name, version: version, identifier: identifier)
    }

    public func run() -> Int32 {
        return 1
        // SDL_CreateSoftwareRenderer(UnsafeMutablePointer<SDL_Surface>!)
    }
}