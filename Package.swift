// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FunctionalRequest",
    
    platforms: [
        .macOS(.v10_12), .iOS(.v10), .tvOS(.v10), .watchOS(.v3)
    ],
    
    products: [
        .library(name: "FunctionalRequest", targets: ["FunctionalRequest"])
    ],
    
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.1.0"))
    ],
    
    targets: [
        .target(name: "FunctionalRequest", dependencies: ["Alamofire"], path: "Sources"),
        .testTarget(name: "FunctionalRequestTests", dependencies: ["FunctionalRequest"])
    ]
)
