import SDL3

// A struct that holds the metadata of an App
public struct SwtAppMetadata {
    let name: String
    let version: String
    let identifier: String

    static let `default` = SwtAppMetdata(name: "SwtWidget App", version: "1.0", identifier: "com.default.app")
}


@MainActor
public class SwtApp {
    static let shared: SwtApp?
    private var mainWidgets: [SwtWidget] = []
    
    private init(metadata: SwtAppMetadata = .default) {
        // Todo: 
        // * Maybe we should set a more rich SDL_SetAppMetadataProperty
        // * Maybe a Getter should be good in this class, using SDL_GetAppMatadata
        SDL_SetAppMetadata(metadata.name, metadata.version, metadata.identifier)
        
        // Initialise SDL video
        if SDL_Init(SDL_INIT_VIDEO) == false {
            print("Couldn't initialise App: \(String(cString: SDL_GetError()))", asError: true)
            return SDL_APP_FAILURE
        }
    }

    public static func create(metadata: SwtAppMetadata = .default) -> SwtApp {
        if shared == nil {
            shared = SwtApp(metadata: metadata)
        }
        return SwtApp(metadata: metadata)
    }

    public func SetMetadata(_ metadata: SwtAppMetadata) {
        SDL_SetAppMetadata(metadata.name, metadata.version, metadata.identifier)
    }

    public GetMetadata() -> SwtAppMetadata {
        let name = SDL_GetAppMetadataProperty("name")
        let version = SDL_GetAppMetadataProperty("version")
        let identifier = SDL_GetAppMetadataProperty("identifier")

        return SwtAppMetadata(name: name, version: version, identifier: identifier)
    }

    public func run() -> Int32 {

        // SDL_CreateSoftwareRenderer(UnsafeMutablePointer<SDL_Surface>!)
    }


}