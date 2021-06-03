// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "app-icon-resize-machine",
    products: [
        .executable(
            name: "app-icon-resize-machine",
            targets: ["app-icon-resize-machine"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.4.0"))
    ],
    targets: [
        .target(
            name: "app-icon-resize-machine",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .testTarget(
            name: "app-icon-resize-machineTests",
            dependencies: ["app-icon-resize-machine"]),
    ]
)
