// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "WakTrainerChart",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "WakTrainerChart",
            targets: ["WakTrainerChart"]
        ),
    ],
    dependencies: [
        // GitHub 리모트 저장소 URL 직접 연결
        .package(url: "https://github.com/iosdevbyul/WakTrainerCoreModels", branch: "main")
    ],
    targets: [
        .target(
            name: "WakTrainerChart",
            dependencies: [
                .product(name: "WakTrainerCoreModels", package: "WakTrainerCoreModels")
            ]
        ),
        .testTarget(
            name: "WakTrainerChartTests",
            dependencies: ["WakTrainerChart"]
        ),
    ]
)
