// swift-tools-version:5.3

import PackageDescription
let package = Package(name: "RestKit",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "RestKit",
            targets: [
                "Network",
                "ObjectMapping",
                "CoreData"
            ])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name:"SOCKit" ,url: "https://github.com/youla-dev/sockit", .branch("xcframework")),
        .package(name:"TransitionKit" ,url: "https://github.com/youla-dev/TransitionKit", .branch("xcframework")),
        .package(name:"RKValueTransformers" ,url: "https://github.com/youla-dev/RKValueTransformers", .branch("xcframework")),
        .package(name:"ISO8601DateFormatterValueTransformer" ,url: "https://github.com/youla-dev/ISO8601DateFormatterValueTransformer", .branch("xcframework"))
    ],
    targets: [
        .target(
            name: "Network",
            dependencies: [
                .byName(name: "SOCKit"),
                .target(name: "ObjectMapping"),
                .target(name: "Support")
            ],
            path: "Code/Network/",
            publicHeadersPath: "Code/Network.h",
            linkerSettings: [
                .linkedFramework("CFNetwork"),
                .linkedFramework("Security"),
                .linkedFramework("MobileCoreServices"),
                .linkedFramework("SystemConfiguration")
            ]
        ),
        .target(name: "ObjectMapping",
                dependencies: [
                    .target(name: "Support"),
                    .byName(name: "RKValueTransformers"),
                    .byName(name: "ISO8601DateFormatterValueTransformer"),
                ],
                path: "Code/ObjectMapping/",
                publicHeadersPath: "Code/ObjectMapping.h"
        ),
        .target(name: "Support",
                dependencies: [
                    .byName(name: "TransitionKit"),
                ],
                path: "Code/Support",
                publicHeadersPath: "Code/RestKit.h"
        ),
        .target(name: "CoreData",
                dependencies: [
                    .target(name: "ObjectMapping")
                ],
                path: "Code/CoreData/",
                publicHeadersPath: "Code/CoreData.h",
                linkerSettings: [.linkedFramework("CoreData")])
    ])
