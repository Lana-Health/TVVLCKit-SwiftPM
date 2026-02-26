
// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "TVVLCKit-SwiftPM",
    platforms: [
        .tvOS(.v13) // Set this to your minimum requirement
    ],
    products: [
        .library(
            name: "TVVLCKit",
            targets: ["TVVLCKitTarget"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "TVVLCKitTarget",
            url: "https://github.com/Lana-Health/TVVLCKit-SwiftPM/releases/download/v3.7.3/TVVLCKit.xcframework.zip",
            checksum: "70fe20dc5128b8c93096fb417be288321c8faa625740ce29a11478e3cac204f8"
        )
    ]
)
