import SDL3

func DoSomethig() {
    print("Starting Prova...")

    // Initialize SDL video systems
    guard SDL_Init(SDL_INIT_VIDEO) == true else {
        fatalError("SDL could not initialize! Error: \(String(cString: SDL_GetError()))")
    }

    let SDL_WINDOW_RESIZABLE: Uint64 = 0x0000000000000020 

    // Create a window at the center of the screen with 800x600 pixel resolution
    let window = SDL_CreateWindow(
        "SDL2 Minimal Demo",
        800, 600,
        SDL_WINDOW_RESIZABLE
    )

    var quit = false
    var event = SDL_Event()

    // Run until app is quit
    while !quit {
        // Poll for (input) events
        while SDL_PollEvent(&event) {
            // if the quit event is triggered ...
            if event.type == SDL_EVENT_QUIT.rawValue {
                // ... quit the run loop
                quit = true
            }
        }

        // wait 100 ms
        SDL_Delay(100)
    }

    // Cleanup SDL resources
    SDL_DestroyWindow(window)
    SDL_Quit()


    // Your additional code here
    print("Prova execution completed")
}