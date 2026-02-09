
// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "TVVLCKit-SPM",
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
            url: "https://github.com/Lana-Health/TVVLCKit-SPM/releases/download/v3.6.0/TVVLCKit.xcframework.zip",
            checksum: "7afd8f0b6e53c73ce164aa5551827468f134e0e7c304b5b08fb3d14860785935"
        )
    ]
)
