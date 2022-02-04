// swift-tools-version:5.0
//
// PaginationKit
//

import PackageDescription

let package = Package(
    name: "PaginationKit",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "PaginationKit",
            targets: ["PaginationKit"]
        )
    ],
    targets: [
        .target(
            name: "PaginationKit",
            path: "PaginationKit"
        )
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
