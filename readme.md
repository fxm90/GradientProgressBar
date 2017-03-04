GradientProgressBar
====================

![Swift3.0](https://img.shields.io/badge/Swift-3.0-green.svg?style=flat) ![Version](https://img.shields.io/cocoapods/v/GradientProgressBar.svg)

A gradient progress bar (UIProgressView). Inspired by [iOS Style Gradient Progress Bar with Pure CSS/CSS3](http://www.cssscript.com/ios-style-gradient-progress-bar-with-pure-css-css3/).

![Sample](http://felix.hamburg/files/github/gradient-progress-bar/screen.png)


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
self.progressView.setProgress(0.75, animated: true)
```

### Version
1.0.0

### Author
Felix Mau (contact(@)felix.hamburg)
