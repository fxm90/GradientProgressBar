//
//  GradientProgressBarViewModel.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 01/20/18.
//  Copyright © 2018 Felix Mau. All rights reserved.
//

import Foundation
import LightweightObservable

/// This view model keeps track of the progress-value and updates the `alphaLayerFrame` accordingly.
class GradientProgressBarViewModel {
    // MARK: - Config

    /// Default animation duration for call to `setProgress(x, animated: true)`.
    ///
    /// - Note: Equals to `CALayer` default animation duration (https://apple.co/2PVTCsB).
    static let defaultAnimationDuration = 0.25

    /// Default animation timing function for animated progress change.
    static let defaultTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)

    // MARK: - Types

    /// Combines all properties for an animated update of a frame.
    struct AnimatedFrameUpdate: Equatable {
        /// Initializes the struct with all values set to zero.
        static let zero = AnimatedFrameUpdate(frame: .zero,
                                              animationDuration: 0.0)

        /// The new frame.
        let frame: CGRect

        /// The animation duration to update the frame with.
        let animationDuration: TimeInterval
    }

    // MARK: - Public properties

    /// The frame for the alpha layer.
    var maskLayerFrameUpdate: Observable<AnimatedFrameUpdate> {
        return maskLayerFrameUpdateSubject.asObservable
    }

    /// The current bounds of the progress view.
    var bounds: CGRect = .zero {
        didSet {
            let didChange = bounds != oldValue
            guard didChange else {
                // Prevent unnecessary UI-updates.
                return
            }

            maskLayerFrameUpdateSubject.value = makeFrameUpdateForCurrentProgress(animated: false)
        }
    }

    ///
    var progress: Float = 0.5 {
        didSet {
            guard shouldUpdateMaskLayerFrameOnProgressChange else { return }

            maskLayerFrameUpdateSubject.value = makeFrameUpdateForCurrentProgress(animated: false)
        }
    }

    /// Animation duration for animated progress change.
    var animationDuration = GradientProgressBarViewModel.defaultAnimationDuration

    /// Animation timing function for animated progress change.
    var timingFunction = GradientProgressBarViewModel.defaultTimingFunction

    // MARK: - Private properties

    private let maskLayerFrameUpdateSubject: Variable<AnimatedFrameUpdate> = Variable(.zero)

    ///
    private var shouldUpdateMaskLayerFrameOnProgressChange = true
    // swiftlint:disable:previous identifier_name

    // MARK: - Public methods

    /// Adjusts the current progress, optionally animating the change.
    ///
    /// - SeeAlso: `UIProgressView.setProgress(_:animated:)`
    func setProgress(_ progress: Float, animated: Bool = false) {
        //
        shouldUpdateMaskLayerFrameOnProgressChange = false
        self.progress = progress
        shouldUpdateMaskLayerFrameOnProgressChange = true

        maskLayerFrameUpdateSubject.value = makeFrameUpdateForCurrentProgress(animated: animated)
    }

    // MARK: - Private methods

    private func makeFrameUpdateForCurrentProgress(animated: Bool) -> AnimatedFrameUpdate {
        var alphaLayerFrame = bounds
        alphaLayerFrame.size.width *= CGFloat(progress)

        let animationDuration: TimeInterval
        if animated {
            animationDuration = self.animationDuration
        } else {
            animationDuration = 0.0
        }

        return AnimatedFrameUpdate(frame: alphaLayerFrame,
                                   animationDuration: animationDuration)
    }
}
