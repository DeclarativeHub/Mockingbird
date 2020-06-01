// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Mockingbird",
    platforms: [
        .macOS(.v10_10), .iOS(.v9), .tvOS(.v9), .watchOS(.v2)
    ],
    products: [
        .library(name: "Mockingbird", targets: ["Mockingbird"])
    ],
    dependencies: [
        .package(url: "https://github.com/DeclarativeHub/ReactiveKit.git", .upToNextMajor(from: "3.15.0"))
    ],
    targets: [
        .target(name: "Mockingbird", dependencies: ["ReactiveKit"], path: "Sources"),
        .testTarget(name: "MockingbirdTests", dependencies: ["Mockingbird"], path: "Tests")
    ]
)
