import Testing
@testable import SwiftWT
import Foundation

@MainActor
@Suite
class SwtAppTests {
    var app: SwtApp?
    var initError: Error?

    init() {
        do {
            app = try SwtApp.get()
        } catch {
            // test fails if app initialization fails
            initError = error
            app = nil
        }
    }

    @Test("SwtApp initialization")
    func testAppInitialization() {
        guard app != nil else {
            Issue.record("App initialization failed: \(initError!)")
            return // Or call an explicit failure function if available
        }
    }

    @Test("SwtApp singleton nature") 
    func testAppSingleton() {
        guard app != nil else {
            Issue.record("App initialization failed: \(initError!)")
            return
        }

        let app1: SwtApp
        let app2: SwtApp
        do {
            app1 = try SwtApp.get()
            app2 = try SwtApp.get()
        } catch {
            Issue.record("Error: \(error)")
            return
        }
        #expect(app1 === app)
        #expect(app2 === app)
        #expect(app1 === app2)  
    }

    @Test("Get and set app metadata")
    func testAppMetadata() {
        guard let app = app else {
            Issue.record("App initialization failed: \(initError!)")
            return
        }

        app.setMetadata(name: "Test App", version: "1.0", identifier: "com.test.app")

        #expect(app.getMetadataProperty(.name) == "Test App")
        #expect(app.getMetadataProperty(.version) == "1.0")
        #expect(app.getMetadataProperty(.identifier) == "com.test.app")

        #expect(app.getMetadataProperty(.creator) == nil)
        #expect(app.getMetadataProperty(.copyright) == nil)
        #expect(app.getMetadataProperty(.url) == nil)
        #expect(app.getMetadataProperty(.type) == "application")
    }
}