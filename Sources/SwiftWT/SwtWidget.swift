import SDL3

// Painter hold an interface to use SDL 2D rendering mechaninsm
class Painter {
    // set up an SDL_Renderer

    func paint() {
        print("Painting...")
    }
}

public protocol Paintable {
    func paintEvent()
}

public class SwtWidget: SwtObject {

}