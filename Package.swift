// swift-tools-version:5.0
//
// PaginationController
//

import PackageDescription

let package = Package(
    name: "PaginationController",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "PaginationController",
            targets: ["PaginationController"]
        )
    ],
    targets: [
        .target(
            name: "PaginationController",
            path: "PaginationController"
        )
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
