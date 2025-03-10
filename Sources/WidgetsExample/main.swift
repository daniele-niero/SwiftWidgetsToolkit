import SwiftWT

@MainActor
func main() {
    guard let app = try? SwtApp.get() else {
        print("Failed to initialize SwtApp")
        return
    }
    let _ = SwtCoreWindow("Nice Test!")
    let _ = app.run()
}

main()

print("Prova execution completed with code")



