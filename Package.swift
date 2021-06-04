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
            ]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name:"SOCKit" ,url: "https://github.com/youla-dev/sockit", .branch("xcframework")),
        .package(name:"TransitionKit" ,url: "https://github.com/youla-dev/TransitionKit", .revision("c73ae370fbf96f2d54ed8cd06db8a9ba17f9342c")),
        .package(name:"RKValueTransformers" ,url: "https://github.com/youla-dev/RKValueTransformers", .revision("10417a668762293f52254ced35db7bca78c453ef")),
        .package(name:"ISO8601DateFormatterValueTransformer" ,url: "https://github.com/youla-dev/ISO8601DateFormatterValueTransformer", .revision("8015e68cbfd1d010ac5765bb99279a6417e396d5"))
    ],
    targets: [
        .target(
            name: "Network",
            dependencies: [
                .byName(name: "SOCKit"),
                .target(name: "ObjectMapping"),
                .target(name: "Support"),
                .target(name: "RKAFNetworking"),
                .target(name: "CoreData")
            ],
            path: "Code/Network/",
            publicHeadersPath: "",
            linkerSettings: [
                .linkedFramework("CFNetwork"),
                .linkedFramework("Security"),
                .linkedFramework("MobileCoreServices"),
                .linkedFramework("SystemConfiguration"),
                .linkedFramework("CoreData"),
            ]
        ),
        .target(
            name: "RKAFNetworking",
            dependencies: [],
            path: "Code/AFNetworking",
            publicHeadersPath: "",
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
                path: "Code/ObjectMapping",
                publicHeadersPath: ""
        ),
        .target(name: "Support",
                dependencies: [
                    .byName(name: "TransitionKit"),
                ],
                path: "Code/Support",
                publicHeadersPath: "",
                linkerSettings: [
                    .linkedFramework("CoreData"),
                ]
        ),
        .target(name: "CoreData",
                dependencies: [
                    .target(name: "ObjectMapping"),
                    .target(name: "Support")
                ],
                path: "Code/CoreData",
                publicHeadersPath: "",
                linkerSettings: [.linkedFramework("CoreData")])
    ]
)
