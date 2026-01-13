# Gradient Progress Bar

![Swift6.2](https://img.shields.io/badge/Swift-6.2-green.svg?style=flat) ![CI Status](https://img.shields.io/github/actions/workflow/status/fxm90/GradientProgressBar/continuous-integration.yml) ![Code Coverage](https://img.shields.io/codecov/c/github/fxm90/GradientProgressBar.svg?style=flat) ![Version](https://img.shields.io/github/v/release/fxm90/GradientProgressBar) ![License](https://img.shields.io/github/license/fxm90/GradientProgressBar?color=333333) ![Platform](https://img.shields.io/badge/platform-iOS-8a8a8a)

A customizable gradient progress bar (`UIProgressView`), with full support for **SwiftUI** and **UIKit**.\
Inspired by [iOS 7 Progress Bar on CodePen](https://codepen.io/marcobiedermann/pen/LExXWW).

### Screenshots

![Example][example]

To run the example project, clone this repository and open the project file from the **Example** directory.

## Requirements

- Swift **6.2**
- Xcode **26**
- iOS **26.0+**

### Compatibility Notes

- **iOS < 26.0 / CocoaPods / Carthage support**  
  Use version **`3.x.x`**
- **iOS < 13.0 support**  
  Use version **`2.x.x`**

## Installation

### Swift Package Manager

**Gradient Progress Bar** is distributed via **Swift Package Manager (SPM)**. Add it to your Xcode project as a package dependency or adapt your `Package.swift` file.

#### Option 1: Xcode

1. Open your project in **Xcode**
2. Go to **File → Add Packages…**
3. Enter the package URL: `https://github.com/fxm90/GradientProgressBar`
4. Choose the version rule (e.g. _Up to Next Major_ starting at **4.0.0**)
5. Add the package to your target

#### Option 2: `Package.swift`

If you manage dependencies manually, add this repository to the `dependencies` section of your `Package.swift`:

```swift
dependencies: [
  .package(
    url: "https://github.com/fxm90/GradientProgressBar",
    from: "4.0.0"
  )
]
```

Then reference the product in your target configuration:

```swift
.product(
  name: "GradientProgressBar",
  package: "GradientProgressBar"
)
```

Once the package is added, import the framework where needed:

```swift
import GradientProgressBar
```

## SwiftUI Integration

_↓ [Scroll down](#uikit-integration) for the UIKit documentation._

Since **v2.1.0**, Gradient Progress Bar provides a custom [`ProgressViewStyle`](https://developer.apple.com/documentation/swiftui/progressviewstyle) for SwiftUI.

### Usage

```swift
struct ContentView: View {

  @State
  private var progress = 0.5

  var body: some View {
    VStack {
      ProgressView(value: progress)
        .progressViewStyle(.gradientProgressBar)
        .frame(height: 3)

      Button("Update progress") {
        progress += 0.1
      }
    }
  }
}
```

### Configuration

```swift
ProgressView(value: progress)
  .progressViewStyle(
    .gradientProgressBar(
      backgroundColor: .gray.opacity(0.05),
      gradientColors: [.indigo, .purple, .pink],
      cornerRadius: 1.5
    )
  )
```

#### Parameters

- **`backgroundColor: Color`**\
  The background color shown behind the gradient (clipped by possible `cornerRadius`).

- **`gradientColors: [Color]`**\
  The colors used for the gradient.

- **`cornerRadius: CGFloat`**\
  The corner-radius used on the background and the progress bar.

### Animating Progress Changes

To animate progress updates, add the [`animation(_:value:)`](<https://developer.apple.com/documentation/swiftui/view/animation(_:value:)>) view modifier.

```swift
ProgressView(value: progress)
  .progressViewStyle(.gradientProgressBar)
  .animation(.easeInOut, value: progress)
```

Refer to Apple’s [`Animation`](https://developer.apple.com/documentation/swiftui/animation) documentation for more advanced customization.

## UIKit Integration

_↑ [Scroll up](#swiftui-integration) for the SwiftUI documentation._

### Usage

```swift
final class UserRegistrationViewController: UIViewController {

  private let gradientProgressBar = GradientProgressBar()

  // ...

  override func viewDidLoad() {
    super.viewDidLoad()

    gradientProgressBar.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(gradientProgressBar)

    NSLayoutConstraint.activate([
      gradientProgressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      gradientProgressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      gradientProgressBar.topAnchor.constraint(equalTo: view.topAnchor),
      gradientProgressBar.heightAnchor.constraint(equalToConstant: 3),
    ])

    gradientProgressBar.progress = 0.5
  }
}
```

### Configuration

```swift
let gradientProgressBar = GradientProgressBar()
gradientProgressBar.animationDuration = 1
gradientProgressBar.gradientColors = [.systemIndigo, .systemPurple, .systemPink]
gradientProgressBar.timingFunction = .easeInOut
```

#### Properties

- **`animationDuration: TimeInterval`**\
   Controls the duration for animated updates when calling `setProgress(_:animated:)`.

- **`gradientColors: [UIColor]`**\
   The colors used for the gradient.

- **`timingFunction: TimingFunction`**\
  Adjusts the animation timing function for animated updates.\
  You can find all pre-defined timing functions [here](Sources/GradientProgressBar/Model/TimingFunction.swift).

### Updating Progress

You can update progress just like a standard `UIProgressView`:

```swift
gradientProgressBar.setProgress(0.75, animated: true)
```

or

```swift
gradientProgressBar.progress = 0.75
```

### Show progress of `WKWebView`

Based on [my gist](https://gist.github.com/fxm90/50d6c73d07c4d9755981b9bb4c5ab931), the example app demonstrates how to attach the progress bar to a `UINavigationBar`.

By observing the `estimatedProgress` property of `WKWebView` via **Key-Value Observing**, the progress bar updates automatically as the page loads.

See the **example project** for a complete implementation.

## Author

Felix Mau
me(@)felix.hamburg

## License

Gradient Progress Bar is released under the **MIT License**. See the `LICENSE` file for details.

[example]: Assets/example.jpg
