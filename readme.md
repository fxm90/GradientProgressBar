GradientProgressBar
====================

![Swift5.0](https://img.shields.io/badge/Swift-5.0-green.svg?style=flat) ![CI Status](https://img.shields.io/github/workflow/status/fxm90/GradientProgressBar/Continuous%20Integration) ![Code Coverage](https://img.shields.io/codecov/c/github/fxm90/GradientProgressBar.svg?style=flat) ![Version](https://img.shields.io/cocoapods/v/GradientProgressBar.svg?style=flat) ![License](https://img.shields.io/cocoapods/l/GradientProgressBar.svg?style=flat) ![Platform](https://img.shields.io/cocoapods/p/GradientProgressBar.svg?style=flat)

A customizable gradient progress bar (UIProgressView). Inspired by [iOS 7 Progress Bar from Codepen](https://codepen.io/marcobiedermann/pen/LExXWW).

### Example
![Example][example]

To run the example project, clone the repo, and open the workspace from the Example directory.

### Requirements
- Swift 5.5
- Xcode 13.2
- iOS 9.0+

### Integration
##### CocoaPods
[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate GradientProgressBar into your Xcode project using CocoaPods, specify it in your `Podfile`:
```ruby
pod 'GradientProgressBar', '~> 2.0'
```


##### Carthage
[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate GradientProgressBar into your Xcode project using Carthage, specify it in your `Cartfile`:
```ogdl
github "fxm90/GradientProgressBar" ~> 2.0
```
Run carthage update to build the framework and drag the built `GradientProgressBar.framework`, as well as the dependency `LightweightObservable.framework`, into your Xcode project.


##### Swift Package Manager
The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but Gradient Progress Bar does support its use on supported platforms.

Once you have your Swift package set up, adding Gradient Progress Bar as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/fxm90/GradientProgressBar", from: "2.0.3")
]
```


### How to use (`UIKit`)
*[Scroll down](#how-to-use-swiftui) for the SwiftUI documentation.*

Simply drop a `UIView` into your View Controller in the Storyboard. Select your view and in the `Identity Inspector` change the class to `GradientProgressBar`.
>Don't forget to change the module to `GradientProgressBar` too.

![Interface Builder][interface-builder]

Setup the constraints for the `UIView` according to your needs.

Import `GradientProgressBar` in your view controller source file.
```swift
import GradientProgressBar
```
Create an `IBOutlet` of the progress view in your view controller source file.
```swift
@IBOutlet weak var gradientProgressView: GradientProgressBar!
```
After that you can set the progress programmatically as you would do on a normal UIProgressView.
```swift
gradientProgressView.setProgress(0.75, animated: true)
```
```swift
gradientProgressView.progress = 0.75
```


### Configuration
#### – Property `animationDuration`
Adjusts the animation duration for calls to `setProgress(_:animated:)`:
```swift
progressView.animationDuration = 2.0
progressView.setProgress(progress, animated: true)
```

#### – Property `gradientColors`
Adjusts the colors, used for the gradient inside the progress-view.
```swift
progressView.gradientColors: [UIColor] = [
    .red,
    .white,
    .blue
]
```


#### – Property `timingFunction`
Adjusts the timing function for calls to `setProgress(_:animated:)`, with animated set to `true`.
```swift
progressView.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
```


### Troubleshooting
#### Interface Builder Support
Unfortunately the Interface Builder support is currently broken for Cocoapods frameworks. If you need Interface Builder support, add the following code to your Podfile and run `pod install` again. Afterwards you should be able to use the `GradientProgressBar` inside the Interface Builder :)
```
  post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
      next unless config.name == 'Debug'

      config.build_settings['LD_RUNPATH_SEARCH_PATHS'] = [
        '$(FRAMEWORK_SEARCH_PATHS)'
      ]
    end
  end
  ```
Source: [Cocoapods – Issue 7606](https://github.com/CocoaPods/CocoaPods/issues/7606#issuecomment-484294739)


### Show progress of `WKWebView`
Based on [my gist](https://gist.github.com/fxm90/50d6c73d07c4d9755981b9bb4c5ab931), the example application also contains the sample code, for attaching the progress view to a `UINavigationBar`. Using "Key-Value Observing" we change the progress of the bar accordingly to the property `estimatedProgress` of the `WKWebView`.

Please have a look at the example application for further details :)


### How to use (`SwiftUI`)
*[Scroll up](#how-to-use-uikit) for the UIKit documentation.*

Since version 2.1.0 this framework provides a [`ProgressViewStyle`](https://developer.apple.com/documentation/swiftui/progressviewstyle) that can be used in SwiftUI.

```swift
struct ExampleView: View {

    @State
    private var progress = 0.5
    
    var body: some View {
        ProgressView(value: progress, total: 1)
            .progressViewStyle(.gradientProgressBar)
            .frame(height: 4)
    }
}
```

### Configuration

```swift
struct ExampleView: View {

    @State
    private var progress = 0.5
    
    var body: some View {
        ProgressView(value: progress, total: 1)
            .progressViewStyle(
                .gradientProgressBar(
                    backgroundColor: .gray.opacity(0.05),
                    gradientColors: [.red, .white, .blue],
                    cornerRadius: 4)
                )
             .frame(height: 8)
    }
}
```


#### – Parameter `backgroundColor`
The background-color shown behind the gradient (clipped by a possible `cornerRadius`).

#### – Parameter `gradientColors`
The colors used for the gradient.

#### – Parameter `cornerRadius`
The corner-radius used on the background and the progress bar.

### Add / Adapt animation
To add an animation you have to wrap the update of the `@State` property inside [`withAnimation(_:_:)`](https://developer.apple.com/documentation/swiftui/withanimation(_:_:)/).

```swift
Button("Animate progress") {
    withAnimation(.easeInOut) {
        progress += 0.1
    }
}
```

Please have a look at the [Apple documentation for `Animation`](https://developer.apple.com/documentation/swiftui/animation) on how to further customise the animation.

### Author
Felix Mau (me(@)felix.hamburg)

### License
GradientProgressBar is available under the MIT license. See the LICENSE file for more info.

[example]: Assets/example.png
[interface-builder]: Assets/interface-builder.png
