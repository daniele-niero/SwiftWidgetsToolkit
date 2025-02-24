// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftWidgetToolkit",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftWT",
            targets: ["SwiftWT"]
        )
        ,.executable(name: "WidgetsExample", targets: ["WidgetsExample"])
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencie
        // System library target for SDL3
        .systemLibrary(
            name: "CSDL3",
            path: "Sources/CSDL3",      
            pkgConfig: nil, //"C:/Dev/vcpkg/installed/x64-windows/lib/pkgconfig/sdl3.pc",
            providers: []
        ),
        .target(
            name: "SwiftWT",
            dependencies: ["CSDL3"]
            ,cSettings: [
                .unsafeFlags(["-I", "C:/Dev/vcpkg/installed/x64-windows/include"])
            ]
            ,linkerSettings: [
                .unsafeFlags([
                    "-I", "C:/Dev/vcpkg/installed/x64-windows/include"  // Path to SDL3 headers
                    ,"-L", "C:/Dev/vcpkg/installed/x64-windows/lib"      // Path to SDL3 library
                    ,"-Xlinker", "/IGNORE:4217"
                ])
            ]
        )
        ,.testTarget(name: "SwiftWTTests", dependencies: ["SwiftWT"])
        ,.executableTarget(
            name: "WidgetsExample", 
            // dependencies: ["SwiftWT"]
            dependencies: ["CSDL3"]
            ,cSettings: [
                .unsafeFlags(["-I", "C:/Dev/vcpkg/installed/x64-windows/include"])
            ]
            ,linkerSettings: [
                .unsafeFlags([
                    "-I", "C:/Dev/vcpkg/installed/x64-windows/include",  // Path to SDL3 headers
                    "-L", "C:/Dev/vcpkg/installed/x64-windows/lib"      // Path to SDL3 library
                    ,"-Xlinker", "/IGNORE:4217"
                ])
            ]
        )
    ]
)

