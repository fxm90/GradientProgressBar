GradientProgressBar
====================

![Swift4.2](https://img.shields.io/badge/Swift-4.2-green.svg?style=flat) [![CI Status](http://img.shields.io/travis/fxm90/GradientProgressBar.svg?style=flat)](https://travis-ci.org/fxm90/GradientProgressBar) [![Version](https://img.shields.io/cocoapods/v/GradientProgressBar.svg?style=flat)](http://cocoapods.org/pods/GradientProgressBar) [![License](https://img.shields.io/cocoapods/l/GradientProgressBar.svg?style=flat)](http://cocoapods.org/pods/GradientProgressBar) [![Platform](https://img.shields.io/cocoapods/p/GradientProgressBar.svg?style=flat)](http://cocoapods.org/pods/GradientProgressBar)

### Example
A customizable gradient progress bar (UIProgressView). Inspired by [iOS 7 Progress Bar from Codepen](https://codepen.io/marcobiedermann/pen/LExXWW).

[![Preview](http://felix.hamburg/files/github/gradient-progress-bar/preview.png)](http://felix.hamburg/files/github/gradient-progress-bar/preview.png)

To run the example project, clone the repo, and run `pod install` from the Example directory first.


### Integration
##### CocoaPods
GradientProgressBar can be added to your project using [CocoaPods](https://cocoapods.org/) by adding the following line to your Podfile:
```
pod 'GradientProgressBar', '~> 1.0'
```

##### Carthage
To integrate GradientProgressBar into your Xcode project using [Carthage](https://github.com/Carthage/Carthage), specify it in your Cartfile:
```
github "fxm90/GradientProgressBar" ~> 1.0
```
Run carthage update to build the framework and drag the built `GradientProgressBar.framework` (as well as the dependency [`Observable.framework`](https://github.com/roberthein/Observable)) into your Xcode project.

### How to use
Simply drop a `UIProgressView` into your View Controller in the Storyboard. Select your progress view and in the `Identity Inspector` change the class to `GradientProgressBar`.
>Don't forget to change the module to `GradientProgressBar` too.

![Interface Builder](http://felix.hamburg/files/github/gradient-progress-bar/interface-builder.png)

Setup the constraints for the UIProgressView according to your needs.

Import `GradientProgressBar` in your view controller source file.
```swift
import GradientProgressBar
```
Create an `IBOutlet` of the progress view in your view controller source file.
```swift
@IBOutlet weak var progressView: GradientProgressBar!
```
After that you can set the progress programmatically as you would do on a normal UIProgressView.
```swift
progressView.setProgress(0.75, animated: true)
```
```swift
progressView.progress = 0.75
```

### Configuration
#### – Property `animationDuration`
As of version __1.1.0__ you can adjust the animation duration for calls to `setProgress(_:animated:)`:
```swift
progressView.animationDuration = 2.0
progressView.setProgress(progress, animated: true)
```

#### – Property `gradientColorList`
As of version __1.2.0__ you can also adjust the gradient colors. Therefore, you'll have to pass an array of type `UIColor` to the property `gradientColorList`.
```swift
progressView.gradientColorList: [UIColor] = [
    .red,
    .white,
    .blue
]
```

#### – Property `timingFunction`
As of version __1.2.0__ you can further adjust the timing function. Therefore, you'll have to pass an instance of `CAMediaTimingFunction` to the property `timingFunction`.
```swift
progressView.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
```

### Show progress of `WKWebView`
Based on [my gist](https://gist.github.com/fxm90/50d6c73d07c4d9755981b9bb4c5ab931), the example application also contains the sample code, for attaching the progress view to a `UINavigationBar`. Using "Key-Value Observing" we change the progress of the bar accordingly to the property `estimatedProgress` of the `WKWebView`.

Please have a look at the example application for further details :)

### Author
Felix Mau (contact(@)felix.hamburg)

### License
GradientProgressBar is available under the MIT license. See the LICENSE file for more info.
