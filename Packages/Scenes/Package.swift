// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Scenes",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Scenes",
            targets: ["Scenes"]),
    ],
    dependencies: [
        .package(path: "../CommonUI"),
        .package(path: "../CommonModels"),
        .package(path: "../Core"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Scenes",
            dependencies: [
                .byName(name: "CommonUI"),
                .byName(name: "CommonModels"),
                .byName(name: "Core"),
            ]
        ),
        .testTarget(
            name: "ScenesTests",
            dependencies: ["Scenes", "CommonModels", "Core"],
            path: "Tests/ScenesTests"
        )
    ]
)
