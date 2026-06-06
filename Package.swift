// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Citadel",

    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],

    products: [
        .library(
            name: "Citadel",
            targets: ["Citadel"]
        ),
    ],

    dependencies: [
        // ✅ USE OFFICIAL REPOS ONLY (critical fix)

        .package(
            url: "https://github.com/apple/swift-nio.git",
            from: "2.68.0"
        ),

        .package(
            url: "https://github.com/apple/swift-nio-ssh.git",
            from: "0.3.0"
        ),

        .package(
            url: "https://github.com/apple/swift-log.git",
            from: "1.0.0"
        ),

        .package(
            url: "https://github.com/attaswift/BigInt.git",
            from: "5.2.0"
        ),

        .package(
            url: "https://github.com/apple/swift-crypto.git",
            from: "3.12.3"
        ),

        .package(
            url: "https://github.com/mtynior/ColorizeSwift.git",
            from: "1.5.0"
        ),
    ],

    targets: [
        .target(
            name: "CCitadelBcrypt"
        ),

        .target(
            name: "Citadel",
            dependencies: [
                "CCitadelBcrypt",
                .product(name: "NIOSSH", package: "swift-nio-ssh"),
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "_CryptoExtras", package: "swift-crypto"),
                .product(name: "BigInt", package: "BigInt"),
                .product(name: "Logging", package: "swift-log"),
            ]
        ),

        .executableTarget(
            name: "CitadelServerExample",
            dependencies: [
                "Citadel",
                .product(name: "ColorizeSwift", package: "ColorizeSwift")
            ]
        ),

        .testTarget(
            name: "CitadelTests",
            dependencies: [
                "Citadel",
                .product(name: "NIOSSH", package: "swift-nio-ssh"),
                .product(name: "BigInt", package: "BigInt"),
                .product(name: "Logging", package: "swift-log"),
            ]
        ),
    ]
)
