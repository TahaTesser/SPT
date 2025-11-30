// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SPT",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "SPT",
            targets: ["SPT"]
        ),
    ],
    targets: [
        .target(
            name: "SPT",
            dependencies: [
                "SPTCore",
                "SPTInstrumentation"
            ]
        ),
        .target(
            name: "SPTInstrumentation",
            dependencies: [
                "SPTCore"
            ]
        ),
        .target(
            name: "SPTCore"
        ),
        .testTarget(
            name: "SPTTests",
            dependencies: ["SPT"]
        ),
    ]
)
