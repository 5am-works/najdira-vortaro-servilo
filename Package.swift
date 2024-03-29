// swift-tools-version:4.1
import PackageDescription

let package = Package(
    name: "NajdiraVortaroServilo",
    products: [
        .library(name: "NajdiraVortaroServilo", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
    ],
    targets: [
        .target(name: "App", dependencies: [
            "Vapor",
        ]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

