import ProjectDescription

let project = Project(
    name: "YettelHomework",
    packages: [
        .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .upToNextMajor(from: "2.8.0")),
        .remote(url: "https://github.com/apple/swift-openapi-generator", requirement: .upToNextMajor(from: "1.6.0")),
        .remote(url: "https://github.com/apple/swift-openapi-runtime", requirement: .upToNextMajor(from: "1.7.0")),
        .remote(url: "https://github.com/apple/swift-openapi-urlsession", requirement: .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "YettelHomework",
            destinations: .iOS,
            product: .app,
            bundleId: "com.madebyaron.YettelHomework",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                    "NSAppTransportSecurity": [
                        "NSExceptionDomains": [
                            "0.0.0.0": [
                                "NSExceptionAllowsInsecureHTTPLoads": true,
                            ],
                        ],
                    ],
                ]
            ),
            sources: ["App/Sources/**"],
            resources: ["App/Resources/**"],
            dependencies: [
                .package(product: "Swinject"),
                .package(product: "OpenAPIRuntime"),
                .package(product: "OpenAPIURLSession"),
                .package(product: "OpenAPIGenerator", type: .plugin),
            ]
        ),
        .target(
            name: "YettelHomeworkTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.madebyaron.YettelHomework",
            infoPlist: .default,
            sources: ["App/Tests/**"],
            resources: [],
            dependencies: [.target(name: "YettelHomework")]
        ),
    ],
    resourceSynthesizers: [
        .assets(),
        .fonts(),
        .strings()
    ]
)
