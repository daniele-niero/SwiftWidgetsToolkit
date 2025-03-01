import SDL3
import Foundation

func Print(_ items: Any..., separator: String = " ", terminator: String = "\n", asError: Bool = false) {
    let output = items.map { "\($0)" }.joined(separator: separator)
    if asError {
        if let data = (output + terminator).data(using: .utf8) {
            FileHandle.standardError.write(data)
        }
    } else {
        Swift.print(output, terminator: terminator)
    }
}

// Create typealiases for opaque SDL types if not already available.
public typealias SDL_Window = OpaquePointer
public typealias SDL_Renderer = OpaquePointer

// These constants are defined in SDL3 headers; adjust if necessary.
let SDL_APP_CONTINUE: Int32 = 0
let SDL_APP_FAILURE: Int32  = -1
let SDL_APP_SUCCESS: Int32  = 1

@MainActor
public class SwtApplication {
    // Shared instance for callback forwarding.
    static var shared: SwtApplication?
    
    // Opaque pointers to our window and renderer.
    var window: SDL_Window?
    var renderer: SDL_Renderer?
    
    public init() {
        // Empty initializer; actual setup happens in appInit.
    }
    
    // This method is called once at startup.
    public func appInit(argc: Int32, argv: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>?) -> Int32 {
        // Set metadata
        SDL_SetAppMetadata("Example Renderer Lines", "1.0", "com.example.renderer-lines")
        
        // Initialize SDL (video only)
        if SDL_Init(SDL_INIT_VIDEO) == false {
            Print("SDL could not initialize! Error: \(String(cString: SDL_GetError()))", asError: true)
            return SDL_APP_FAILURE
        }
        
        // Create window and renderer in one call.
        if SDL_CreateWindowAndRenderer("examples/renderer/lines", 640, 480, 0, &window, &renderer) == false {
            Print("Couldn't create window/renderer: \(String(cString: SDL_GetError()))", asError: true)
            return SDL_APP_FAILURE
        }
        
        return SDL_APP_CONTINUE // Carry on with the program.
    }
    
    // This method is called when a new event occurs.
    public func appEvent(event: UnsafeMutablePointer<SDL_Event>?) -> Int32 {
        guard let event = event else {
            return SDL_APP_CONTINUE
        }
        if event.pointee.type == SDL_EVENT_QUIT.rawValue {
            return SDL_APP_SUCCESS  // End the program, reporting success.
        }
        return SDL_APP_CONTINUE   // Continue otherwise.
    }
    
    // This method is called once per frame.
    public func appIterate() -> Int32 {
        // Define an array of line points.
        let linePoints: [SDL_FPoint] = [
            SDL_FPoint(x: 100, y: 354),
            SDL_FPoint(x: 220, y: 230),
            SDL_FPoint(x: 140, y: 230),
            SDL_FPoint(x: 320, y: 100),
            SDL_FPoint(x: 500, y: 230),
            SDL_FPoint(x: 420, y: 230),
            SDL_FPoint(x: 540, y: 354),
            SDL_FPoint(x: 400, y: 354),
            SDL_FPoint(x: 100, y: 354)
        ]
        
// Clear the renderer to a grey background.
SDL_SetRenderDrawColor(renderer, 100, 100, 100, UInt8(SDL_ALPHA_OPAQUE))
// Clear the renderer to a grey background.
SDL_SetRenderDrawColor(renderer, 100, 100, 100, UInt8(SDL_ALPHA_OPAQUE))
// Clear the renderer to a grey background.
        SDL_SetRenderDrawColor(renderer, 100, 100, 100, UInt8(SDL_ALPHA_OPAQUE))
        // Clear the renderer to a grey background.
        SDL_SetRenderDrawColor(renderer, 100, 100, 100, UInt8(SDL_ALPHA_OPAQUE))
        // Clear the renderer to a grey background.
        SDL_SetRenderDrawColor(renderer, 100, 100, 100, UInt8(SDL_ALPHA_OPAQUE))
        // Clear the renderer to a grey background.
        SDL_SetRenderDrawColor(renderer, 100, 100, 100, UInt8(SDL_ALPHA_OPAQUE))
        SDL_RenderClear(renderer)
        
        // Draw individual brown lines.
        SDL_SetRenderDrawColor(renderer, 127, 49, 32, UInt8(SDL_ALPHA_OPAQUE))
        SDL_RenderLine(renderer, 240, 450, 400, 450)
        SDL_RenderLine(renderer, 240, 356, 400, 356)
        SDL_RenderLine(renderer, 240, 356, 240, 450)
        SDL_RenderLine(renderer, 400, 356, 400, 450)
        
        // Draw connected green lines.
        SDL_SetRenderDrawColor(renderer, 0, 255, 0, UInt8(SDL_ALPHA_OPAQUE))
        // SDL_RenderLines expects a pointer to SDL_FPoint and a count.
        _ = linePoints.withUnsafeBufferPointer { buffer in
            SDL_RenderLines(renderer, buffer.baseAddress, Int32(buffer.count))
        }
        
        // Draw animated lines radiating from a center.
        for i in 0..<360 {
            let size: Float = 30.0
            let centerX: Float = 320.0
            let centerY: Float = 95.0 - (size / 2.0)
            let r = SDL_rand(256)
            let g = SDL_rand(256)
            let b = SDL_rand(256)
            SDL_SetRenderDrawColor(renderer, UInt8(r), UInt8(g), UInt8(b), UInt8(SDL_ALPHA_OPAQUE))
            SDL_RenderLine(renderer,
                           Float(centerX),
                           Float(centerY),
                           Float(centerX + SDL_sinf(Float(i)) * size),
                           Float(centerY + SDL_cosf(Float(i)) * size))
        }
        
        // Present the rendered frame.
        SDL_RenderPresent(renderer)
        return SDL_APP_CONTINUE
    }
    
    // This method runs once at shutdown.
    public func appQuit(result: Int32) {
        // No explicit cleanup here; SDL will clean up window/renderer if needed.
    }
}

// Global C-callable functions for SDL's main callback API.

@MainActor
public func SDL_AppInit(_ appstate: UnsafeMutablePointer<UnsafeMutableRawPointer?>?,
                         _ argc: Int32,
                         _ argv: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>?) -> Int32 {
    let application = SwtApplication()
    SwtApplication.shared = application
    // If appstate is provided, store a retained pointer.
    if let appstate = appstate {
        appstate.pointee = UnsafeMutableRawPointer(Unmanaged.passRetained(application).toOpaque())
    }
    return application.appInit(argc: argc, argv: argv)
}

@MainActor
public func SDL_AppEvent(_ appstate: UnsafeMutableRawPointer?,
                         _ event: UnsafeMutablePointer<SDL_Event>?) -> Int32 {
    return SwtApplication.shared?.appEvent(event: event) ?? SDL_APP_CONTINUE
}

@MainActor
public func SDL_AppIterate(_ appstate: UnsafeMutableRawPointer?) -> Int32 {
    return SwtApplication.shared?.appIterate() ?? SDL_APP_CONTINUE
}

@MainActor
public func SDL_AppQuit(_ appstate: UnsafeMutableRawPointer?, _ result: Int32) {
    SwtApplication.shared?.appQuit(result: result)
    if let appstate = appstate {
        Unmanaged<SwtApplication>.fromOpaque(appstate).release()
    }
}


// Main function to run the application

        var event = SDL_Event()
        let application = SwtApplication()
        SwtApplication.shared = application
        
        // Initialize the application
        if application.appInit(argc: CommandLine.argc, argv: CommandLine.unsafeArgv) != SDL_APP_CONTINUE {
            print("AH SHIT!!")
        }
        
        // Event loop
        while true {
            while SDL_PollEvent(&event) == true {
                if application.appEvent(event: &event) == SDL_APP_SUCCESS {
                    application.appQuit(result: SDL_APP_SUCCESS)
                    break
                }
            }
            if application.appIterate() != SDL_APP_CONTINUE {
                application.appQuit(result: SDL_APP_FAILURE)
                break
            }
        }