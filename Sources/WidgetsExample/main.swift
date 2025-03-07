import SwiftWT



print("Starting Prova...")

do {
    let app = try SwtApp.get()
    let _ = SwtCoreWindow("Nice Test!")
    let _ = app.run()
} catch {
    print("An error occurred: \(error)")
}
print("Prova execution completed with code")



