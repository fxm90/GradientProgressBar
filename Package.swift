// swift-tools-version:5.5

import PackageDescription

let package = Package(name: "GradientProgressBar",
                      platforms: [.iOS(.v13)],
                      products: [
                          .library(name: "GradientProgressBar",
                                   targets: ["GradientProgressBar"]),
                      ],
                      targets: [
                          .target(name: "GradientProgressBar",
                                  path: "GradientProgressBar/"),
                          .testTarget(name: "GradientProgressBarTests",
                                      dependencies: ["GradientProgressBar"],
                                      path: "Example/ExampleTests/"),
                      ])
