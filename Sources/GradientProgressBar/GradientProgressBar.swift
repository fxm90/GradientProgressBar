//
//  GradientProgressBar.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 01.03.17.
//  Copyright © 2017 Felix Mau. All rights reserved.
//

import UIKit

/// A protocol that defines an interface for displaying and updating progress.
///
/// This protocol mirrors the behavior and API of `UIProgressView`, allowing
/// custom progress view implementations (such as `GradientProgressBar`)
/// to be used interchangeably with `UIProgressView`.
///
/// - SeeAlso: <https://developer.apple.com/documentation/uikit/uiprogressview>
@MainActor
protocol UIProgressHandling {
  /// The current progress shown by the receiver (between 0.0 and 1.0, inclusive).
  var progress: Float { get set }

  /// Adjusts the current progress shown by the receiver, optionally animating the change.
  ///
  /// - Parameters:
  ///   - progress: The new progress value (between 0.0 and 1.0, inclusive).
  ///   - animated: `true` if the change should be animated, `false` if the change should happen immediately.
  func setProgress(_ progress: Float, animated: Bool)
}

extension UIProgressView: UIProgressHandling {}

/// A progress bar that displays a customizable gradient to indicate progress.
///
/// ## Overview
///
/// `GradientProgressBar` is a drop-in replacement for `UIProgressView` that renders a horizontal gradient instead of a solid color.
/// It conforms to the same API patterns as `UIProgressView`, making it easy to swap between the two.
/// You can customize the appearance with your own gradient colors, animation duration, and timing function.
///
/// ## Usage
///
/// Create a gradient progress bar and set its progress:
///
/// ```swift
/// let progressBar = GradientProgressBar()
/// progressBar.progress = 0.5
/// ```
///
/// Animate progress changes:
///
/// ```swift
/// progressBar.setProgress(1.0, animated: true)
/// ```
///
/// ## Customization
///
/// - ``gradientColors``: The array of colors for the horizontal gradient.
/// - ``animationDuration``: The duration for progress animations.
/// - ``timingFunction``: The timing function for progress animations.
///
/// - SeeAlso:
///   - ``TimingFunction`` for configuring animation timing.
///   - ``GradientProgressBarViewStyle`` for the SwiftUI equivalent.
@MainActor
public class GradientProgressBar: UIView {

  // MARK: - Public Properties

  /// The array of colors for the horizontal gradient.
  public var gradientColors: [UIColor] = UIColor.GradientProgressBar.gradientColors {
    didSet {
      gradientLayer.colors = gradientColors.map(\.cgColor)
    }
  }

  /// The animation duration for calls to `setProgress(x, animated: true)`.
  public var animationDuration: TimeInterval {
    get { viewModel.animationDuration }
    set { viewModel.animationDuration = newValue }
  }

  /// The animation timing function for calls to `setProgress(x, animated: true)`.
  public var timingFunction: TimingFunction {
    get { viewModel.timingFunction }
    set { viewModel.timingFunction = newValue }
  }

  // MARK: - Private Properties

  /// The layer containing the gradient.
  private let gradientLayer: CAGradientLayer = {
    let layer = CAGradientLayer()
    layer.anchorPoint = .zero
    layer.startPoint = .zero
    layer.endPoint = CGPoint(x: 1, y: 0)

    return layer
  }()

  /// The layer for masking the current progress in the gradient layer.
  private let maskLayer: CALayer = {
    let maskLayer = CALayer()
    maskLayer.backgroundColor = UIColor.white.cgColor

    return maskLayer
  }()

  /// The view-model managing the state of our mask layer.
  private let viewModel = ViewModel()

  // MARK: - Instance Lifecycle

  override public init(frame: CGRect) {
    super.init(frame: frame)

    setUpView()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    setUpView()
  }

  // MARK: - View Lifecycle

  override public func layoutSubviews() {
    super.layoutSubviews()

    // `CALayer` is not affected by auto-layout, so any change in the size of the view will not change the gradient layer.
    // That's why we have to update the frame here manually.
    gradientLayer.frame = bounds

    // Inform the view-model about the changed bounds, so it can calculate a new frame for the mask-layer,
    // based on the current progress value.
    viewModel.bounds = bounds
  }

  override public func updateProperties() {
    super.updateProperties()

    animateMaskLayer(
      layerAnimation: viewModel.maskLayerAnimation,
    )
  }

  // MARK: - Private Methods

  private func setUpView() {
    backgroundColor = .GradientProgressBar.backgroundColor

    // Mask the gradient layer so that only the portion representing the current progress is rendered.
    gradientLayer.mask = maskLayer
    gradientLayer.colors = gradientColors.map(\.cgColor)
    layer.addSublayer(gradientLayer)
  }

  private func animateMaskLayer(layerAnimation: LayerAnimation) {
    CATransaction.begin()
    CATransaction.setAnimationDuration(layerAnimation.duration)
    CATransaction.setAnimationTimingFunction(layerAnimation.timingFunction.caMediaTimingFunction)

    maskLayer.frame = layerAnimation.frame

    CATransaction.commit()
  }
}

// MARK: - `UIProgressHandling` conformance

extension GradientProgressBar: UIProgressHandling {
  public var progress: Float {
    get { viewModel.progress }
    set { viewModel.progress = newValue }
  }

  public func setProgress(_ progress: Float, animated: Bool) {
    viewModel.setProgress(progress, animated: animated)
  }
}

// MARK: - Helper

private extension TimingFunction {
  /// Returns a `CAMediaTimingFunction` equivalent of this `TimingFunction`.
  var caMediaTimingFunction: CAMediaTimingFunction {
    switch self {
    case .default:
      CAMediaTimingFunction(name: .default)
    case .easeIn:
      CAMediaTimingFunction(name: .easeIn)
    case .easeOut:
      CAMediaTimingFunction(name: .easeOut)
    case .easeInOut:
      CAMediaTimingFunction(name: .easeInEaseOut)
    case .linear:
      CAMediaTimingFunction(name: .linear)
    // swiftlint:disable:next identifier_name
    case let .custom(x1, y1, x2, y2):
      CAMediaTimingFunction(controlPoints: x1, y1, x2, y2)
    }
  }
}

// MARK: - Preview

#Preview {
  let viewController = UIViewController()

  let gradientProgressBar = GradientProgressBar()
  gradientProgressBar.progress = 0.75
  gradientProgressBar.translatesAutoresizingMaskIntoConstraints = false
  viewController.view.addSubview(gradientProgressBar)

  NSLayoutConstraint.activate([
    gradientProgressBar.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: 24),
    gradientProgressBar.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -24),
    gradientProgressBar.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
    gradientProgressBar.heightAnchor.constraint(equalToConstant: 3),
  ])

  return viewController
}
