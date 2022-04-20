// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BusinessCardSwiftPackage",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "BusinessCardSwiftPackage",
            targets: ["BusinessCardSwiftPackage"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "BusinessCardSwiftPackage",
            dependencies: []),
        .testTarget(
            name: "BusinessCardSwiftPackageTests",
            dependencies: ["BusinessCardSwiftPackage"]),
    ]
)
