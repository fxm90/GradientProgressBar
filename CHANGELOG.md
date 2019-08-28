# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

---

## [Unreleased]


## [2.0.0] - 2019-28-08
### Changed
 - Changed subclassing from `UIProgressView` to `UIView`, in order to make framework more failure safe (e.g. due to accidentally setting `progressTintColor`)
### Added
 - Interface builder support

## [1.2.9] - 2019-09-06
### Fixed
 - Fix Carthage build failed due to non shared scheme 
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
   - If you need them in your project, feel free to copy & paste to following file into you project: https://gist.github.com/fxm90/1350d27abf92af3be59aaa9eb72c9310

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
 - Fix frame not updated correctly
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
 - Fix UIProgressView always updates via animation
### Changed
 - Refactor entire code

## [1.0.0] - 2017-04-03
- Initial release


[Unreleased]: https://github.com/fxm90/GradientProgressBar/compare/2.0.0...master
[1.2.9]: https://github.com/fxm90/GradientProgressBar/compare/1.2.9...2.0.0
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
