// swift-tools-version: 5.6

import PackageDescription

let package = Package(
  name: "Escape",
  products: [
    .library(name: "Escape", targets: ["Escape"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "Escape",
      dependencies: []),
    .testTarget(
      name: "EscapeTests",
      dependencies: ["Escape"]),
  ]
)
