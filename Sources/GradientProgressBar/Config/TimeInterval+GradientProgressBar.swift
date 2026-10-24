//
//  TimeInterval+GradientProgressBar.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 10.01.26.
//  Copyright © 2026 Felix Mau. All rights reserved.
//

public import Foundation

public extension TimeInterval {

  /// Time related configuration values for `GradientProgressBar`.
  enum GradientProgressBar {
    /// The default animation duration for calls to `setProgress(x, animated: true)`.
    ///
    /// - Note: Equals to `CALayer` default animation duration.
    ///         <https://developer.apple.com/documentation/quartzcore/calayer/add(_:forkey:)>
    public static let progressAnimationDuration = 0.25
  }
}
