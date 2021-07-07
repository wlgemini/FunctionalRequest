// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FunctionalRequest",
    
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)
    ],
    
    products: [
        .library(name: "FunctionalRequest", targets: ["FunctionalRequest"])
    ],
    
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.2.0"))
    ],
    
    targets: [
        .target(name: "FunctionalRequest", dependencies: ["Alamofire"], path: "Sources"),
        //.testTarget(name: "FunctionalRequestTests", dependencies: ["FunctionalRequest"])
    ]
)
