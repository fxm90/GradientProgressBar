//
//  GradientProgressBarViewStyle.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 02.02.22.
//  Copyright © 2022 Felix Mau. All rights reserved.
//

import SwiftUI

/// A custom `ProgressViewStyle` that displays progress as a horizontal gradient bar.
///
/// ## Overview
///
/// Use this style with SwiftUI's `ProgressView` to create a progress indicator that fills
/// from leading to trailing with a customizable gradient.
///
/// ## Usage
///
/// Apply this style to a `ProgressView` using the `.progressViewStyle(_:)` modifier:
///
/// ```swift
/// // Using the default configuration.
/// ProgressView(value: 0.5)
///   .progressViewStyle(.gradientProgressBar)
///   .frame(height: 3)
///
/// // Using custom colors and corner radius.
/// ProgressView(value: 0.5)
///   .progressViewStyle(
///     .gradientProgressBar(
///       backgroundColor: .gray.opacity(0.05),
///       gradientColors: [.indigo, .purple, .pink],
///       cornerRadius: 1.5
///     )
///   )
///   .frame(height: 3)
/// ```
///
/// - SeeAlso: ``GradientProgressBar`` for the UIKit equivalent.
public struct GradientProgressBarViewStyle: ProgressViewStyle {

  // MARK: - Public Properties

  /// The color shown behind the gradient, visible where progress is incomplete.
  public let backgroundColor: Color

  /// The array of colors for the horizontal gradient.
  public let gradientColors: [Color]

  /// The corner radius applied to the background and progress bar.
  public let cornerRadius: CGFloat

  // MARK: - Public Methods

  public func makeBody(configuration: Configuration) -> some View {
    RoundedRectangle(cornerRadius: cornerRadius)
      .fill(backgroundColor)
      .overlay {
        GeometryReader { proxy in
          LinearGradient(
            colors: gradientColors,
            startPoint: .leading,
            endPoint: .trailing,
          )
          .mask(alignment: .leading) {
            RoundedRectangle(cornerRadius: cornerRadius)
              .frame(width: (configuration.fractionCompleted ?? 0) * proxy.size.width)
          }
        }
      }
  }
}

// MARK: - Helper

public extension ProgressViewStyle where Self == GradientProgressBarViewStyle {
  /// Returns a gradient progress bar style using the default configuration.
  ///
  /// ## Usage
  ///
  /// ```swift
  /// ProgressView(value: 0.5)
  ///   .progressViewStyle(.gradientProgressBar)
  /// ```
  static var gradientProgressBar: Self {
    gradientProgressBar()
  }

  /// Returns a gradient progress bar style with customizable appearance.
  ///
  /// ## Usage
  ///
  /// ```swift
  /// ProgressView(value: 0.5)
  ///   .progressViewStyle(
  ///     .gradientProgressBar(
  ///       backgroundColor: .gray.opacity(0.05),
  ///       gradientColors: [.indigo, .purple, .pink],
  ///       cornerRadius: 1.5
  ///     )
  ///   )
  /// ```
  ///
  /// - Parameters:
  ///   - backgroundColor: The color shown behind the gradient, visible where progress is incomplete.
  ///   - gradientColors: The array of colors for the horizontal gradient.
  ///   - cornerRadius: The corner radius applied to the background and progress bar.
  static func gradientProgressBar(
    backgroundColor: Color = .GradientProgressBar.backgroundColor,
    gradientColors: [Color] = Color.GradientProgressBar.gradientColors,
    cornerRadius: CGFloat = .GradientProgressBar.cornerRadius,
  ) -> Self {
    GradientProgressBarViewStyle(
      backgroundColor: backgroundColor,
      gradientColors: gradientColors,
      cornerRadius: cornerRadius,
    )
  }
}

// MARK: - Preview

#Preview {
  ProgressView(value: 0.7)
    .progressViewStyle(.gradientProgressBar)
    .frame(height: 3)
    .padding()
}
