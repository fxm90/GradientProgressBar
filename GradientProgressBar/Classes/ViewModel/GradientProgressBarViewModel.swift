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
    var alphaLayerAnimatedFrameUpdate: Observable<AnimatedFrameUpdate> {
        return alphaLayerAnimatedFrameUpdateSubject.asObservable
    }

    /// The current bounds of the progress view.
    var bounds: CGRect = .zero {
        didSet {
            let didChange = bounds != oldValue
            guard didChange else {
                // Prevent unnecessary UI-updates, as we set this value from `layoutSubviews()`,
                // which gets triggered every time the progress value is changed.
                return
            }

            alphaLayerAnimatedFrameUpdateSubject.value = makeFrameUpdateForCurrentProgress(animated: false)
        }
    }

    /// Animation duration for animated progress change.
    var animationDuration = GradientProgressBarViewModel.defaultAnimationDuration

    /// Animation timing function for animated progress change.
    var timingFunction = GradientProgressBarViewModel.defaultTimingFunction

    // MARK: - Private properties

    private let alphaLayerAnimatedFrameUpdateSubject: Variable<AnimatedFrameUpdate> = Variable(.zero)

    /// Keep track of our internal progress property. We need this e.g. if we rotate the device,
    /// and therefore have to adjust the alpha-layer-frame according to this property.
    private var progress: Float = 0.0

    // MARK: - Public methods

    /// Adjusts the current progress, optionally animating the change.
    ///
    /// - SeeAlso: `UIProgressView.setProgress(_:animated:)`
    func setProgress(_ progress: Float, animated: Bool = false) {
        self.progress = progress

        alphaLayerAnimatedFrameUpdateSubject.value = makeFrameUpdateForCurrentProgress(animated: animated)
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
