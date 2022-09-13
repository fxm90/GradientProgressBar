//
//  MaskLayerViewModel.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 08.08.19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import Combine
import CoreGraphics
import Foundation
import QuartzCore

/// This view model keeps track of the progress-value and updates the `maskLayer` accordingly.
final class MaskLayerViewModel {

    // MARK: - Public properties

    /// Observable frame-animation for the mask layer.
    var maskLayerFrameAnimation: AnyPublisher<FrameAnimation, Never> {
        maskLayerFrameAnimationSubject
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    /// The current bounds of the progress view.
    var bounds: CGRect = .zero {
        didSet {
            // Update mask-layer frame accordingly.
            maskLayerFrameAnimationSubject.value = makeMaskLayerFrameAnimation(animated: false)
        }
    }

    /// The current progress.
    var progress: Float {
        get { _progress }
        set {
            _progress = newValue.clamped(to: 0 ... 1)
            maskLayerFrameAnimationSubject.value = makeMaskLayerFrameAnimation(animated: false)
        }
    }

    /// Animation duration for an animated progress change.
    var animationDuration = TimeInterval.GradientProgressBar.progressAnimationDuration

    /// Animation timing function for an animated progress change.
    var timingFunction = CAMediaTimingFunction.GradientProgressBar.progressAnimationFunction

    // MARK: - Private properties

    /// The actual storage for our progress.
    ///
    /// We store the value on a separate properties for two reasons:
    /// - This makes sure the progress stays between zero and one.
    /// - The setter of `progress` can set a progress and always update the frame of the layer without an animation.
    ///   The method `setProgress(_:animated:)` can set a progress and afterwards update the frame with a possible animation.
    private var _progress: Float = 0.5

    private let maskLayerFrameAnimationSubject: CurrentValueSubject<FrameAnimation, Never> = CurrentValueSubject(.zero)

    // MARK: - Public methods

    /// Adjusts the current progress, optionally animating the change.
    func setProgress(_ progress: Float, animated: Bool = false) {
        _progress = progress.clamped(to: 0 ... 1)
        maskLayerFrameAnimationSubject.value = makeMaskLayerFrameAnimation(animated: animated)
    }

    // MARK: - Private methods

    private func makeMaskLayerFrameAnimation(animated: Bool) -> FrameAnimation {
        var maskLayerFrame = bounds
        maskLayerFrame.size.width *= CGFloat(progress)

        let animationDuration: TimeInterval
        if animated {
            animationDuration = self.animationDuration
        } else {
            animationDuration = 0
        }

        return FrameAnimation(frame: maskLayerFrame,
                              duration: animationDuration,
                              timingFunction: timingFunction)
    }
}

// MARK: - Supporting Types

extension MaskLayerViewModel {

    /// Combines all properties for an animated update of a frame.
    struct FrameAnimation: Equatable {
        /// Initializes the struct with all values set to zero / default.
        static let zero = FrameAnimation(frame: .zero,
                                         duration: 0,
                                         timingFunction: CAMediaTimingFunction(name: .default))

        /// The new rect for the frame.
        let frame: CGRect

        /// The animation duration to update the frame with.
        let duration: TimeInterval

        /// The timing function to update the frame with (e.g. `easeInOut`).
        let timingFunction: CAMediaTimingFunction
    }
}

// MARK: - Helper

extension Comparable {

    /// Clamps the current value to the boundaries of the given `limits`.
    ///
    /// - Source: https://stackoverflow.com/a/40868784
    func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }
}
