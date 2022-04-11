// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Velour",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Velour",
            targets: ["Velour"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Velour",
            dependencies: ["VelourCore"],
            path: "Sources/Velour",
            resources: [.copy("Pipelines")]
        ),
        .target(
            name: "VelourCore",
            path: "Sources/VelourCore",
            publicHeadersPath: "include",
            cSettings: [.headerSearchPath("include")]
        ),
        .testTarget(
            name: "VelourTests",
            dependencies: ["Velour"]),
    ],
    swiftLanguageVersions: [.v5]
)
