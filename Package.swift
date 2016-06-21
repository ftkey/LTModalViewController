import PackageDescription

let package = Package(
    name: "LTModalViewController",
    dependencies: [
        .Package(url: "https://github.com/ftkey/LTModalViewController.git", versions: Version(1,0,0)..<Version(2,0,0)),
    ]
)

