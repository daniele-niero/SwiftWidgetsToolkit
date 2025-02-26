// swift-tools-version:6.0
import PackageDescription
import Foundation

#if os(Windows)
let vcpkgRoot = ProcessInfo.processInfo.environment["VCPKG_ROOT"] ?? "C:/vcpkg"
let sdlIncludePath = "\(vcpkgRoot)/installed/x64-windows/include"
let sdlLibPath = "\(vcpkgRoot)/installed/x64-windows/lib"

// These settings will only be applied on Windows.
let windowsCSettings: [CSetting] = [
    .unsafeFlags(["-I", sdlIncludePath])
]
let windowsLinkerSettings: [LinkerSetting] = [
    .unsafeFlags(["-I", sdlIncludePath, "-L", sdlLibPath, "-Xlinker", "/IGNORE:4217"])
]
#else
// For non-Windows platforms, no extra settings are required.
let windowsCSettings: [CSetting] = []
let windowsLinkerSettings: [LinkerSetting] = []
#endif

let package = Package(
    name: "SwiftWidgetToolkit",
    products: [
        // .library(
        //     name: "SwiftWT",
        //     targets: ["SwiftWT"]
        // ),
        .executable(
            name: "WidgetsExample",
            targets: ["WidgetsExample"]
        )
    ],
    targets: [
        // System library target for SDL3.
        .systemLibrary(
            name: "CSDL3",
            path: "Sources/CSDL3",
            pkgConfig: nil,
            providers: []
        ),
        // .target(
        //     name: "SwiftWT",
        //     dependencies: ["CSDL3"],
        //     cSettings: windowsCSettings,
        //     linkerSettings: windowsLinkerSettings
        // ),
        // .testTarget(
        //     name: "SwiftWTTests",
        //     dependencies: ["SwiftWT"]
        // ),
        .executableTarget(
            name: "WidgetsExample",
            dependencies: ["CSDL3"],
            cSettings: windowsCSettings,
            linkerSettings: windowsLinkerSettings
        )
    ]
)
