import ProjectDescription

let projectName: String = "Dailiary"
let deploymentTargetVersion: String = "11.0"

// MARK: - Actions

let targetActions = [
    TargetAction.post(
        path: "Scripts/SwiftlintRunScript.sh",
        arguments: [],
        name: "SwiftLint"
    )
]


// MARK: - Settings

let appTargetSettings = Settings(
    base: [
        "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "$(inherited)",
    ]
)
let frameworkTargetSettings = Settings(
    base: [
        "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "$(inherited)",
    ]
)
let testsTargetSettings = Settings(
    base: [
        "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "$(inherited)"
    ]
)


// MARK: - Project

let project = Project(
    name: "\(projectName)",
    targets: [
        Target(
            name: "\(projectName)",
            platform: .iOS,
            product: .app,
            bundleId: "com.jinuman.\(projectName)",
            deploymentTarget: .iOS(targetVersion: deploymentTargetVersion, devices: .iphone),
            infoPlist: InfoPlist(stringLiteral: "Projects/\(projectName)/Supporting Files/\(projectName)-Info.plist"),
            sources: ["Projects/\(projectName)/Sources/**"],
            resources: ["Projects/\(projectName)/Resources/**"],
            actions: targetActions,
            dependencies: [
                .cocoapods(path: "."),
                .target(name: "\(projectName)Foundation"),
                .target(name: "\(projectName)UI"),
                .target(name: "\(projectName)Reactive"),
            ],
            settings: appTargetSettings
        ),
        Target(
            name: "\(projectName)Tests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jinuman.\(projectName)Tests",
            infoPlist: .default,
            sources: ["Projects/\(projectName)/Tests/**"],
            dependencies: [
                .target(name: "\(projectName)"),
            ],
            settings: testsTargetSettings
        ),
        Target(
            name: "\(projectName)Foundation",
            platform: .iOS,
            product: .framework,
            bundleId: "com.jinuman.\(projectName)Foundation",
            deploymentTarget: .iOS(targetVersion: deploymentTargetVersion, devices: .iphone),
            infoPlist: .default,
            sources: ["Projects/\(projectName)Foundation/Sources/**"],
            dependencies: [],
            settings: frameworkTargetSettings
        ),
        Target(
            name: "\(projectName)FoundationTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jinuman.\(projectName)FoundationTests",
            infoPlist: .default,
            sources: ["Projects/\(projectName)Foundation/Tests/**"],
            dependencies: [
                .target(name: "\(projectName)Foundation"),
                .target(name: "\(projectName)Test")
            ],
            settings: testsTargetSettings
        ),
        Target(
            name: "\(projectName)UI",
            platform: .iOS,
            product: .framework,
            bundleId: "com.jinuman.\(projectName)UI",
            deploymentTarget: .iOS(targetVersion: deploymentTargetVersion, devices: .iphone),
            infoPlist: .default,
            sources: ["Projects/\(projectName)UI/Sources/**"],
            dependencies: [
                .target(name: "\(projectName)Foundation"),
            ],
            settings: frameworkTargetSettings
        ),
        Target(
            name: "\(projectName)UITests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jinuman.\(projectName)UITests",
            infoPlist: .default,
            sources: ["Projects/\(projectName)UI/Tests/**"],
            dependencies: [
                .target(name: "\(projectName)UI"),
                .target(name: "\(projectName)Test")
            ],
            settings: testsTargetSettings
        ),
        Target(
            name: "\(projectName)Reactive",
            platform: .iOS,
            product: .framework,
            bundleId: "com.jinuman.\(projectName)Reactive",
            deploymentTarget: .iOS(targetVersion: deploymentTargetVersion, devices: .iphone),
            infoPlist: .default,
            sources: ["Projects/\(projectName)Reactive/Sources/**"],
            dependencies: [],
            settings: frameworkTargetSettings
        ),
        Target(
            name: "\(projectName)ReactiveTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jinuman.\(projectName)ReactiveTests",
            infoPlist: .default,
            sources: ["Projects/\(projectName)Reactive/Tests/**"],
            dependencies: [
                .target(name: "\(projectName)Reactive"),
                .target(name: "\(projectName)Test")
            ],
            settings: testsTargetSettings
        ),
        Target(
            name: "\(projectName)Test",
            platform: .iOS,
            product: .framework,
            bundleId: "com.jinuman.\(projectName)Test",
            deploymentTarget: .iOS(targetVersion: deploymentTargetVersion, devices: .iphone),
            infoPlist: .default,
            sources: ["Projects/\(projectName)Test/Sources/**"],
            dependencies: [],
            settings: frameworkTargetSettings
        ),
        Target(
            name: "\(projectName)TestTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jinuman.\(projectName)TestTests",
            infoPlist: .default,
            sources: ["Projects/\(projectName)Test/Tests/**"],
            dependencies: [
                .target(name: "\(projectName)Test"),
            ],
            settings: testsTargetSettings
        ),
    ]
)
