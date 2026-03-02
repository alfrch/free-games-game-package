// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Game",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Game",
            targets: ["Game"]
        ),
    ],
    dependencies: [
      .package(
        url: "https://github.com/realm/realm-swift.git",
        from: "10.40.0"
      ),
      .package(
        url: "https://github.com/Alamofire/Alamofire.git",
          .upToNextMajor(from: "5.2.0")
      ),
      .package(
        url: "https://github.com/alfrch/free-games-core-package.git",
        from: "1.0.1"
      )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Game",
            dependencies: [
              .product(name: "RealmSwift", package: "realm-swift"),
              .product(name: "Core", package: "free-games-core-package"),
              "Alamofire"
            ]
        ),

    ]
)
