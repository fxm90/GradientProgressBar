// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "GradientProgressBar",
  platforms: [.iOS(.v26)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "GradientProgressBar",
      targets: ["GradientProgressBar"],
    ),
  ],
  dependencies: [
    .package(
      url: "https://github.com/pointfreeco/swift-snapshot-testing",
      from: "1.12.0",
    ),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "GradientProgressBar",
    ),
    .testTarget(
      name: "GradientProgressBarTests",
      dependencies: [
        "GradientProgressBar",
        .product(
          name: "SnapshotTesting",
          package: "swift-snapshot-testing",
        ),
      ],
      exclude: [
        "SnapshotTests/README.md",
      ],
      resources: [
        .copy("SnapshotTests/__Snapshots__"),
      ],
    ),
  ],
)
