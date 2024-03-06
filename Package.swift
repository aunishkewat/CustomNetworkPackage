// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CustomNetworkPackage",
    products: [
        .library(
            name: "CustomNetwork",
            targets: ["CustomNetwork"]),
    ],
    targets: [
        .binaryTarget(
            name: "CustomNetwork",
            path: "./CustomNetwork.xcframework"
        ),
    ]
)
