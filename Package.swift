// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "Topaz",
  products: [
    .library(
      name: "Topaz",
      targets: ["Topaz"]),
    .executable(
      name: "TopazClient",
      targets: ["TopazClient"]),
  ],
  dependencies: [
  ],
  targets: [
    /// A minimal reimplementation of the Swift standard library.
    .target(
      name: "Topaz",
      dependencies: ["CTopazRuntime"],
      swiftSettings: [
        // Disable the implicit `import Swift` statement for this module.
        // We don't want to use the normal Swift standard library.
        .unsafeFlags(["-parse-stdlib"])
    ]),

    /// A C library that serves as the runtime for Topaz.
    /// Used to implement (stubs for) runtime functions the Swift compiler expects,
    /// and also to wrap calls into C APIs to interact with the operating system.
    .target(
      name: "CTopazRuntime",
      dependencies: []),

    /// An executable for playing with and testing the Topaz library.
    .target(
      name: "TopazClient",
      dependencies: ["Topaz"],
      swiftSettings: [
        // Disable the implicit `import Swift` statement for this module.
        // We don't want to use the normal Swift standard library.
        .unsafeFlags(["-parse-stdlib"])
      ]),
  ]
)
