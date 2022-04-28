//
//  MaskLayerViewModel.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 08.08.19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import Foundation
import CoreGraphics
import QuartzCore
import LightweightObservable

/// This view model keeps track of the progress-value and updates the `maskLayer` accordingly.
final class MaskLayerViewModel {

    // MARK: - Types

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

    // MARK: - Public properties

    /// Observable frame-animation for the mask layer.
    var maskLayerFrameAnimation: Observable<FrameAnimation> {
        maskLayerFrameAnimationSubject
    }

    /// The current bounds of the progress view.
    var bounds: CGRect = .zero {
        didSet {
            guard bounds != oldValue else {
                // Prevent unnecessary UI-updates.
                return
            }

            // Update mask-layer frame accordingly.
            maskLayerFrameAnimationSubject.value = maskLayerFrameAnimationForCurrentProgress(animated: false)
        }
    }

    /// The current progress.
    var progress: Float = 0.5 {
        didSet {
            // Make sure progress value fits our bounds.
            progress = min(1, max(0, progress))

            if shouldUpdateMaskLayerFrameOnProgressChange {
                maskLayerFrameAnimationSubject.value = maskLayerFrameAnimationForCurrentProgress(animated: false)
            }
        }
    }

    /// Animation duration for an animated progress change.
    var animationDuration = TimeInterval.GradientProgressBar.progressAnimationDuration

    /// Animation timing function for an animated progress change.
    var timingFunction = CAMediaTimingFunction.GradientProgressBar.progressAnimationFunction

    // MARK: - Private properties

    private let maskLayerFrameAnimationSubject: Variable<FrameAnimation> = Variable(.zero)

    /// Boolean flag whether we should calculate a new frame for the mask-layer
    /// on setting the `progress` value.
    ///
    /// - SeeAlso: `setProgress(_:animated:)`
    private var shouldUpdateMaskLayerFrameOnProgressChange = true
    // swiftlint:disable:previous identifier_name

    // MARK: - Public methods

    /// Adjusts the current progress, optionally animating the change.
    func setProgress(_ progress: Float, animated: Bool = false) {
        // We don't want to update the mask-layer frame on setting the progress value here, as we might have to do it animated.
        shouldUpdateMaskLayerFrameOnProgressChange = false
        self.progress = progress
        shouldUpdateMaskLayerFrameOnProgressChange = true

        maskLayerFrameAnimationSubject.value = maskLayerFrameAnimationForCurrentProgress(animated: animated)
    }

    // MARK: - Private methods

    private func maskLayerFrameAnimationForCurrentProgress(animated: Bool) -> FrameAnimation {
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
