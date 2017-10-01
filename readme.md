GradientProgressBar
====================

![Swift3.0](https://img.shields.io/badge/Swift-3.0-green.svg?style=flat) ![Version](https://img.shields.io/cocoapods/v/GradientProgressBar.svg) [![CI Status](http://img.shields.io/travis/fxm90/GradientProgressBar.svg?style=flat)](https://travis-ci.org/fxm90/GradientProgressBar) [![Version](https://img.shields.io/cocoapods/v/GradientProgressBar.svg?style=flat)](http://cocoapods.org/pods/GradientProgressBar) [![License](https://img.shields.io/cocoapods/l/GradientProgressBar.svg?style=flat)](http://cocoapods.org/pods/GradientProgressBar) [![Platform](https://img.shields.io/cocoapods/p/GradientProgressBar.svg?style=flat)](http://cocoapods.org/pods/GradientProgressBar)

### Example
A gradient progress bar (UIProgressView). Inspired by [iOS Style Gradient Progress Bar with Pure CSS/CSS3](http://www.cssscript.com/ios-style-gradient-progress-bar-with-pure-css-css3/).

![Sample](http://felix.hamburg/files/github/gradient-progress-bar/screen.png)

To run the example project, clone the repo, and run `pod install` from the Example directory first.


### Integration
GradientProgressBar can be added to your project using [CocoaPods](https://cocoapods.org/) by adding the following line to your Podfile:
```
pod 'GradientProgressBar', '~> 1.0'
```
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
As of version 1.1.0 you can adjust the animation duration:
```
progressView.animationDuration = 2.0
progressView.setProgress(progress, animated: true)
```

### Author
Felix Mau (contact(@)felix.hamburg)

### License
GradientProgressBar is available under the MIT license. See the LICENSE file for more info.
