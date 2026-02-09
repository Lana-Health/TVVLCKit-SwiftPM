
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
            url: "https://github.com/Lana-Health/TVVLCKit-SPM/releases/download/v3.7.2/TVVLCKit.xcframework.zip",
            checksum: "21cc4523408a2b74da56e859e19dea6b1102e0a72128d16a4dec8a923c74f16a"
        )
    ]
)
