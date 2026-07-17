// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "SwiftDI",

    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10)
    ],

    products: [
        .library(
            name: "SwiftDI",
            targets: ["SwiftDI"]
        )
    ],

    targets: [
        .target(
            name: "SwiftDI"
        )
    ],

    swiftLanguageModes: [.v6]
)
