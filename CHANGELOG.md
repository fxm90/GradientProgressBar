# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

## [4.0.0] - 2026-01-31

### Changed

- Complete rewrite using modern Swift features including the [`Observation`](https://developer.apple.com/documentation/Observation) framework.
  Therefore the minimum required iOS version increased to iOS `26.0` and Swift `6.2`.
- Reorganized project structure to follow Swift Package Manager conventions (`Sources/` and `Tests/` directories).
- Rewrote example application using SwiftUI with improved feature demonstrations.
- Updated README with comprehensive documentation and new screenshots.

### Removed

- Dropped support for CocoaPods. This follows CocoaPods' [read-only trunk notice](https://blog.cocoapods.org/CocoaPods-Specs-Repo/). Please migrate to Swift Package Manager.
- Dropped support for Carthage. Please migrate to Swift Package Manager.
- Removed legacy example project and Podfile infrastructure.

## [3.0.0] - 2022-07-10

### Changed

- Use `Combine` instead of dependency `LightweightObservable`. Therefore the minimum required iOS version increased to iOS `13.0`. Otherwise there are no breaking changes.

## [2.1.1] - 2022-12-09

### Fixed

- Fixed wrong minimum iOS deployment target when using Carthage.

## [2.1.0] - 2022-06-03

### Added

- Added support for SwiftUI, by providing `.gradientProgressBar` as a `ProgressViewStyle`.

## [2.0.3] - 2020-18-01

### Added

- Added support for Swift Package Manager.

## [2.0.2] - 2019-29-11

### Changed

- Updated dependency [LightweightObservable](https://github.com/fxm90/LightweightObservable) to version 2 and adapt changes.

## [2.0.1] - 2019-23-09

### Added

- Support for dark mode on iOS 13

### Changed

- Set access control to `public` for layers on `GradientProgressBar`, in order to allow further configuration in subclasses ([#8])

## [2.0.0] - 2019-28-08

### Changed

- Changed subclassing from `UIProgressView` to `UIView`, in order to make framework more failure safe (e.g. due to accidentally setting `progressTintColor`)

### Added

- Interface builder support

## [1.2.9] - 2019-09-06

### Fixed

- Fixed Carthage build failed due to non shared scheme

### Changed

- Moved observable implementation into a framework (`LightweightObservable`) and added it as dependency

## [1.2.8] - 2019-04-04

### Changed

- Added support for Swift 5.0

## [1.2.7] - 2019-03-16

### Changed

- Changed class access control to `open` in order to allow subclassing `GradientProgressBar` (fixes issue [#5](https://github.com/fxm90/GradientProgressBar/issues/5)).

## [1.2.6] - 2019-02-13

### Changed

- Remove dependency `Observable` in favour of a more lightweight implementation
- Small internal refactorings and cleanup

## [1.2.5] - 2018-16-11

### Changed

- Adapt code to support new version from dependency `Observable`

## [1.2.4] - 2018-22-09

### Changed

- Changes for Swift 4.2
- Removed `UIColor` initializers, as they're not required for the project to work (and it's not very common to use hex color codes in iOS)
  - If you need them in your project, feel free to copy & paste to following file into your project: https://gist.github.com/fxm90/1350d27abf92af3be59aaa9eb72c9310

## [1.2.3] - 2018-29-08

### Changed

- Refactored to observables

## [1.2.2] - 2018-14-04

### Changed

- Updates for Swift 4.1
- Formatted code

## [1.2.1] - 2018-27-01

### Added

- Further documentation

### Changed

- Refactored code to use MVVM
- Format code

## [1.2.0] - 2018-14-01

### Added

- Allow setting custom gradient colors
- Allow setting custom animation timing function

## [1.1.4] - 2017-27-12

### Changed

- Updated to Swift 4.0

## [1.1.3] - 2017-31-10

### Added

- Further tests

### Fixed

- Fixed frame not updated correctly

### Changed

- Updated documentation

## [1.1.2] - 2017-01-10

### Added

- Refactored project structure to match "pod lib create" / TravisCI integration
- Added example project

## [1.1.1] - 2017-27-08

### Added

- Basic tests / TravisCI integration
- Refactored extension for UIColor initializer
- Changelog

## [1.1.0] - 2017-18-08

### Added

- Configuration for animation duration

### Changed

- Renamed and moved default values struct into main class
- Allow subclassing "GradientProgressBar()"
- Lint code

## [1.0.1] - 2017-15-08

### Fixed

- Fixed UIProgressView always updates via animation

### Changed

- Refactor entire code

## [1.0.0] - 2017-04-03

- Initial release

[Unreleased]: https://github.com/fxm90/GradientProgressBar/compare/4.0.0...main
[4.0.0]: https://github.com/fxm90/GradientProgressBar/compare/3.0.0...4.0.0
[3.0.0]: https://github.com/fxm90/GradientProgressBar/compare/2.1.1...3.0.0
[2.1.1]: https://github.com/fxm90/GradientProgressBar/compare/2.1.0...2.1.1
[2.1.0]: https://github.com/fxm90/GradientProgressBar/compare/2.0.3...2.1.0
[2.0.3]: https://github.com/fxm90/GradientProgressBar/compare/2.0.2...2.0.3
[2.0.2]: https://github.com/fxm90/GradientProgressBar/compare/2.0.1...2.0.2
[2.0.1]: https://github.com/fxm90/GradientProgressBar/compare/2.0.0...2.0.1
[2.0.0]: https://github.com/fxm90/GradientProgressBar/compare/1.2.9...2.0.0
[1.2.9]: https://github.com/fxm90/GradientProgressBar/compare/1.2.8...1.2.9
[1.2.8]: https://github.com/fxm90/GradientProgressBar/compare/1.2.7...1.2.8
[1.2.7]: https://github.com/fxm90/GradientProgressBar/compare/1.2.6...1.2.7
[1.2.6]: https://github.com/fxm90/GradientProgressBar/compare/1.2.5...1.2.6
[1.2.5]: https://github.com/fxm90/GradientProgressBar/compare/1.2.4...1.2.5
[1.2.4]: https://github.com/fxm90/GradientProgressBar/compare/1.2.3...1.2.4
[1.2.3]: https://github.com/fxm90/GradientProgressBar/compare/1.2.2...1.2.3
[1.2.2]: https://github.com/fxm90/GradientProgressBar/compare/1.2.1...1.2.2
[1.2.1]: https://github.com/fxm90/GradientProgressBar/compare/1.2.0...1.2.1
[1.2.0]: https://github.com/fxm90/GradientProgressBar/compare/1.1.4...1.2.0
[1.1.4]: https://github.com/fxm90/GradientProgressBar/compare/1.1.3...1.1.4
[1.1.3]: https://github.com/fxm90/GradientProgressBar/compare/1.1.2...1.1.3
[1.1.2]: https://github.com/fxm90/GradientProgressBar/compare/1.1.1...1.1.2
[1.1.1]: https://github.com/fxm90/GradientProgressBar/compare/1.1.0...1.1.1
[1.1.0]: https://github.com/fxm90/GradientProgressBar/compare/1.0.1...1.1.0
[1.0.1]: https://github.com/fxm90/GradientProgressBar/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/fxm90/GradientProgressBar
