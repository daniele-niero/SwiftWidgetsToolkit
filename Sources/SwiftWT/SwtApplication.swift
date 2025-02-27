import SDL3

// A struct that holds the metadata of an App
public struct SwtAppMetadata {
    let name: String
    let version: String
    let identifier: String

    static public let `default` = SwtAppMetadata(name: "SwtWidget App", version: "1.0", identifier: "com.default.app")
}


@MainActor
public class SwtApp {
    static var shared: SwtApp?
    private var mainWidgets: [SwtWidget] = []

    enum SwtAppError: Error {
        case InitializationFailed(String)
    }
    
    private init(metadata: SwtAppMetadata = .default) throws {
        // Todo: 
        // * Maybe we should set a more rich SDL_SetAppMetadataProperty
        // * Maybe a Getter should be good in this class, using SDL_GetAppMatadata
        SDL_SetAppMetadata(metadata.name, metadata.version, metadata.identifier)
        
        // Initialise SDL video
        if SDL_Init(SDL_INIT_VIDEO) == false {
            let errorMessage = "Couldn't initialise App: \(String(cString: SDL_GetError()))" 
            // print("Couldn't initialise App: \(String(cString: SDL_GetError()))", asError: true)
            throw SwtAppError.InitializationFailed(errorMessage)
        }
    }

    public static func create(metadata: SwtAppMetadata = .default) -> SwtApp {
        if shared == nil {
            shared = try SwtApp(metadata: metadata)
        }
        return shared!
    }

    public func SetMetadata(_ metadata: SwtAppMetadata) {
        SDL_SetAppMetadata(metadata.name, metadata.version, metadata.identifier)
    }

    public func GetMetadata() -> SwtAppMetadata {
        let name: String = String(cString: SDL_GetAppMetadataProperty("name"))
        let version: String = String(cString: SDL_GetAppMetadataProperty("version"))
        let identifier: String = String(cString: SDL_GetAppMetadataProperty("identifier"))

        return SwtAppMetadata(name: name, version: version, identifier: identifier)
    }

    public func run() -> Int32 {

        // SDL_CreateSoftwareRenderer(UnsafeMutablePointer<SDL_Surface>!)
    }


}