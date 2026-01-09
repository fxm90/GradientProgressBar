//
//  TimingFunction.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 10.01.26.
//  Copyright © 2026 Felix Mau. All rights reserved.
//

import Foundation

/// Represents a timing function for animations, abstracting `CAMediaTimingFunction`
/// into a Sendable and thread-safe type.
public enum TimingFunction: Equatable, Sendable {

  /// The default timing function (equivalent to `CAMediaTimingFunctionName.default`).
  case `default`

  /// An ease-in timing function (equivalent to `CAMediaTimingFunctionName.easeIn`),
  /// starts slowly and accelerates towards the end.
  case easeIn

  /// An ease-out timing function (equivalent to `CAMediaTimingFunctionName.easeOut`),
  /// starts quickly and decelerates towards the end.
  case easeOut

  /// An ease-in-ease-out timing function (equivalent to `CAMediaTimingFunctionName.easeInEaseOut`),
  /// starts slowly, speeds up in the middle, and slows down at the end.
  case easeInOut

  /// A linear timing function (equivalent to `CAMediaTimingFunctionName.linear`),
  /// progresses at a constant pace.
  case linear

  /// A custom cubic Bezier timing function with control points.
  ///
  /// - Parameters:
  ///   - x1: The X coordinate of the first control point.
  ///   - y1: The Y coordinate of the first control point.
  ///   - x2: The X coordinate of the second control point.
  ///   - y2: The Y coordinate of the second control point.
  case custom(x1: Float, y1: Float, x2: Float, y2: Float)
  // swiftlint:disable:previous identifier_name
}
