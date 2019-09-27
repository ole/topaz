// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "Topaz",
  products: [
    .library(
      // The product name can remain "Topaz", but the target published by the product
      // must be named "Swift".
      name: "Topaz",
      targets: ["Swift"]),
    .executable(
      name: "TopazClient",
      targets: ["TopazClient"]),
  ],
  dependencies: [
  ],
  targets: [
    /// A minimal reimplementation of the Swift standard library.
    .target(
      /// The target must be named "Swift" because the compiler expects to find certain types
      /// (e.g. ExpressibleBy…Literal) in the "Swift" module.
      name: "Swift",
      dependencies: ["CTopazRuntime", "CTopazLib"],
      path: "Sources/Topaz",
      swiftSettings: [
        // Disable the implicit `import Swift` statement for this module.
        // We don't want to use the normal Swift standard library.
        .unsafeFlags([
            "-nostdimport",
            "-parse-stdlib"
        ])
    ]),

    /// A C library that serves as the runtime for Topaz.
    /// Used to implement (stubs for) runtime functions the Swift compiler expects,
    /// and also to wrap calls into C APIs to interact with the operating system.
    .target(
        name: "CTopazRuntime",
        dependencies: [],
        cxxSettings: [
            .unsafeFlags([
                "-std=gnu++14"
            ])
        ]
    ),


    .target(
      name: "CTopazLib",
      dependencies: []),

    /// An executable for playing with and testing the Topaz library.
    .target(
      name: "TopazClient",
      dependencies: ["Swift"],
      swiftSettings: [
        // Disable the implicit `import Swift` statement for this module.
        // We don't want to use the normal Swift standard library.
        .unsafeFlags([
            "-nostdimport",
            "-parse-stdlib"
        ])
      ]),
  ]
)
