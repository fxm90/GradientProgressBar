GradientProgressBar
====================

![Swift5.0](https://img.shields.io/badge/Swift-5.0-green.svg?style=flat) [![CI Status](http://img.shields.io/travis/fxm90/GradientProgressBar.svg?style=flat)](https://travis-ci.org/fxm90/GradientProgressBar) ![Code Coverage](https://img.shields.io/codecov/c/github/fxm90/GradientProgressBar.svg?style=flat) ![Version](https://img.shields.io/cocoapods/v/GradientProgressBar.svg?style=flat) ![License](https://img.shields.io/cocoapods/l/GradientProgressBar.svg?style=flat) ![Platform](https://img.shields.io/cocoapods/p/GradientProgressBar.svg?style=flat)

A customizable gradient progress bar (UIProgressView). Inspired by [iOS 7 Progress Bar from Codepen](https://codepen.io/marcobiedermann/pen/LExXWW).

### Example
[![Example](http://felix.hamburg/files/github/gradient-progress-bar/preview.png)](http://felix.hamburg/files/github/gradient-progress-bar/preview.png)

To run the example project, clone the repo, and open the workspace from the Example directory.

### Integration
##### CocoaPods
GradientProgressBar can be added to your project using [CocoaPods](https://cocoapods.org/) by adding the following line to your Podfile:
```
pod 'GradientProgressBar', '~> 1.0'
```

**Interface Builder Support**
The Interface Builder support is currently broken for Cocoapods frameworks. As a workaround you can add the following code to your Podfile and run `pod install` again. Afterwards you should be able to use the `GradientProgressBar` inside the Interface Builder :)
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
   [Cocoapods – Issue 7606](https://github.com/CocoaPods/CocoaPods/issues/7606#issuecomment-484294739)

##### Carthage
To integrate GradientProgressBar into your Xcode project using [Carthage](https://github.com/Carthage/Carthage), specify it in your Cartfile:
```
github "fxm90/GradientProgressBar" ~> 1.0
```
Run carthage update to build the framework and drag the built `GradientProgressBar.framework`, as well as the dependency `LightweightObservable.framework`, into your Xcode project.

### How to use
Simply drop a `UIView` into your View Controller in the Storyboard. Select your view and in the `Identity Inspector` change the class to `GradientProgressBar`.
>Don't forget to change the module to `GradientProgressBar` too.

![Interface Builder](http://felix.hamburg/files/github/gradient-progress-bar/interface-builder.png)

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
As of version __1.1.0__ you can adjust the animation duration for calls to `setProgress(_:animated:)`:
```swift
progressView.animationDuration = 2.0
progressView.setProgress(progress, animated: true)
```

#### – Property `gradientColors`
As of version __1.2.0__ you can also adjust the gradient colors. Therefore, you'll have to pass an array of type `UIColor` to the property `gradientColors`.
```swift
progressView.gradientColors: [UIColor] = [
    .red,
    .white,
    .blue
]
```

#### – Property `timingFunction`
As of version __1.2.0__ you can further adjust the timing function. Therefore, you'll have to pass an instance of `CAMediaTimingFunction` to the property `timingFunction`.
```swift
progressView.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
```

### Show progress of `WKWebView`
Based on [my gist](https://gist.github.com/fxm90/50d6c73d07c4d9755981b9bb4c5ab931), the example application also contains the sample code, for attaching the progress view to a `UINavigationBar`. Using "Key-Value Observing" we change the progress of the bar accordingly to the property `estimatedProgress` of the `WKWebView`.

Please have a look at the example application for further details :)

### Author
Felix Mau (contact(@)felix.hamburg)

### License
GradientProgressBar is available under the MIT license. See the LICENSE file for more info.
