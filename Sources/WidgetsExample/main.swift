import SwiftWT

@MainActor
func main() -> EAppResult{
    guard let app = try? SwtApp.get() else {
        print("Failed to initialize SwtApp")
        return EAppResult.failure
    }
    let widget = SwtWidget()
    widget.show()
    return app.run()
}

let result: EAppResult = main()

print("Prova execution completed with code \(result)")



