
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
            url: "https://github.com/Lana-Health/TVVLCKit-SPM/releases/download/v3.7.2/TVVLCKit.xcframework.zip",
            checksum: "37bc6a8198f96ccd06aebc5ee878eeacc8c40a81c47bb8c67a8f50ec40dbf95d"
        )
    ]
)
