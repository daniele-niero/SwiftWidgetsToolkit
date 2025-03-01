import Testing
@testable import SwiftWT
import Foundation



@Test func testAppMetadata() async {
    let app: SwtApp
    do {
        app = try await SwtApp.get()
    } catch {
        print("Error: \(error)")
        return
    }
    
    let metadata = SwtAppMetadata(name: "Test App", version: "1.0", identifier: "com.test.app")
    await app.setMetadata(metadata)
    let appMetadata = await app.getMetadata()
    
    #expect(appMetadata != nil)
    if let appMetadata = appMetadata {
        #expect(appMetadata.name == "Test App")
        #expect(appMetadata.version == "1.0")
        #expect(appMetadata.identifier == "com.test.app")
    }
}

// Test SwtApp initialization
@Test func testAppInitialization() async {
    let app: SwtApp
    do {
        app = try await SwtApp.get()
    } catch {
        // test fails if app initialization fails
        Issue.record("Error: \(error)")
        return
    }
    
    let metadata = await app.getMetadata()
    #expect(metadata != nil)
}

// Test SwtApp singleton nature
@Test func testAppSingleton() async {
    let app1: SwtApp
    let app2: SwtApp
    do {
        app1 = try await SwtApp.get()
        app2 = try await SwtApp.get()
    } catch {
        Issue.record("Error: \(error)")
        return
    }
    #expect(app1 === app2)
}