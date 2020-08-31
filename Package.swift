// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "FriendlyId",
  products: [
    .library(
      name: "FriendlyId",
      targets: ["FriendlyId"]
    ),
    .executable(
      name: "friendly-id",
      targets: ["FriendlyIdCLI"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.3.0")),
    .package(url: "https://github.com/attaswift/BigInt.git", .upToNextMinor(from: "5.2.0"))
  ],
  targets: [
    .target(
      name: "FriendlyId",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "BigInt", package: "BigInt")
      ]),
    .target(
      name: "FriendlyIdCLI",
      dependencies: ["FriendlyId"]
    ),
    .testTarget(
      name: "FriendlyIdTests",
      dependencies: ["FriendlyId"]),
  ]
)
