//
//  GradientProgressBar+ViewModel.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 08.08.19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import Foundation
import Observation

extension GradientProgressBar {

  /// This view model manages the state of the `GradientProgressBar`.
  @MainActor
  @Observable
  final class ViewModel {

    // MARK: - Internal Properties

    /// The animation for the mask layer.
    private(set) var maskLayerAnimation: LayerAnimation = .zero

    /// The current bounds of the progress view.
    @ObservationIgnored
    var bounds: CGRect = .zero {
      didSet {
        updateMaskLayerAnimation(animated: false)
      }
    }

    /// The current progress.
    @ObservationIgnored
    var progress: Float {
      get { _progress }
      set {
        _progress = newValue.clamped(to: 0 ... 1)
        updateMaskLayerAnimation(animated: false)
      }
    }

    /// The animation duration for an animated progress change.
    @ObservationIgnored
    var animationDuration: TimeInterval = .GradientProgressBar.progressAnimationDuration

    /// The animation timing function for an animated progress change.
    @ObservationIgnored
    var timingFunction: TimingFunction = .default

    // MARK: - Private Properties

    /// The backing storage for `progress`.
    ///
    /// We use a separate property for two reasons:
    /// - It guarantees that the stored value is always clamped between 0 and 1.
    /// - It allows different update behaviors:
    ///   - The `progress` setter updates the layer’s frame immediately, without animation.
    ///   - `setProgress(_:animated:)` updates the frame after setting the value and may animate the change.
    ///   This distinction would not be possible with a single property.
    @ObservationIgnored
    private var _progress: Float = 0.5

    // MARK: - Internal Methods

    /// Adjusts the current progress, optionally animating the change.
    func setProgress(_ progress: Float, animated: Bool = false) {
      _progress = progress.clamped(to: 0 ... 1)
      updateMaskLayerAnimation(animated: animated)
    }

    // MARK: - Private Methods

    private func updateMaskLayerAnimation(animated: Bool) {
      var maskLayerFrame = bounds
      maskLayerFrame.size.width *= CGFloat(progress)

      let duration = animated ? animationDuration : 0

      maskLayerAnimation = LayerAnimation(
        frame: maskLayerFrame,
        duration: duration,
        timingFunction: timingFunction,
      )
    }
  }
}

// MARK: - Helper

private extension Comparable {
  /// Clamps the current value to the boundaries of the given `limits`.
  ///
  /// Source: <https://stackoverflow.com/a/40868784>
  func clamped(to limits: ClosedRange<Self>) -> Self {
    min(max(self, limits.lowerBound), limits.upperBound)
  }
}
