// swift-tools-version:5.0

import PackageDescription

let package = Package(name: "GradientProgressBar",
                      platforms: [.iOS(.v9)],
                      products: [
                          .library(name: "GradientProgressBar",
                                   targets: ["GradientProgressBar"])
                      ],
                      dependencies: [
                          .package(url: "https://github.com/fxm90/LightweightObservable",
                                   .upToNextMajor(from: "2.0.0"))
                      ],
                      targets: [
                          .target(name: "GradientProgressBar",
                                  dependencies: ["LightweightObservable"],
                                  path: "GradientProgressBar/Classes"),
                          .testTarget(name: "GradientProgressBarTests",
                                      dependencies: ["GradientProgressBar"],
                                      path: "Example/Tests/")
                      ])
