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
            dependencies: []),
        .testTarget(
            name: "VelourTests",
            dependencies: ["Velour"]),
    ]
)