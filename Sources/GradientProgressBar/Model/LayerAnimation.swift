//
//  LayerAnimation.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 10.01.26.
//  Copyright © 2026 Felix Mau. All rights reserved.
//

import CoreGraphics
import Foundation

/// A value type that describes an animation applied to a `CALayer`.
struct LayerAnimation: Equatable, Sendable {

  /// A `LayerAnimation` with a zero frame and no animation.
  static let zero = LayerAnimation(
    frame: .zero,
    duration: 0,
    timingFunction: .default,
  )

  /// The target frame of the layer at the end of the animation.
  let frame: CGRect

  /// The duration, in seconds, over which the frame change is animated.
  let duration: TimeInterval

  /// The timing function that defines the pacing of the animation (e.g. `easeInOut`).
  let timingFunction: TimingFunction
}
