//
//  GradientProgressBarViewModel.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 20.01.18.
//

import Foundation
import Observable

// MARK: - View Model

class GradientProgressBarViewModel {
    // MARK: - Config

    /// Default animation duration for call to `setProgress(x, animated: true)`.
    ///
    /// Note: Equals to CALayer default animation duration
    static let defaultAnimationDuration = 0.25

    /// Default animation timing function for animated progress change.
    static let defaultTimingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

    // MARK: - Types

    /// Combines all properties for an animated update of a frame.
    struct AnimatedFrameUpdate: Equatable {
        /// Initializes the struct with "0".
        static let zero = AnimatedFrameUpdate(frame: .zero, animationDuration: 0.0)

        /// The new frame.
        let frame: CGRect

        /// The animation duration to update the frame with.
        let animationDuration: TimeInterval
    }

    // MARK: - Public properties

    /// The frame for the gradient layer.
    let gradientLayerFrame: Observable<CGRect> = Observable(.zero)

    /// The frame for the alpha layer.
    let alphaLayerFrame: Observable<AnimatedFrameUpdate> = Observable(.zero)

    /// Gradient colors for the progress view.
    let gradientColorList: Observable = Observable(UIColor.defaultGradientColorList)

    /// Bounds for the progress bar.
    var bounds = CGRect.zero {
        didSet {
            gradientLayerFrame.value = bounds

            setAlphaLayerFrame(for: progress, animated: false)
        }
    }

    /// Current progress value.
    var progress: Float = 0.0 {
        didSet {
            guard shouldInformListeners else { return }

            setAlphaLayerFrame(for: progress, animated: false)
        }
    }

    /// Animation duration for animated progress change.
    var animationDuration = GradientProgressBarViewModel.defaultAnimationDuration

    /// Animation timing function for animated progress change.
    var timingFunction = GradientProgressBarViewModel.defaultTimingFunction

    // MARK: - Private properties

    /// Boolean flag, whether setting the `progress` property should inform the listeners.
    private var shouldInformListeners = true

    // MARK: - Private methods

    private func alphaLayerFrame(for progress: Float) -> CGRect {
        var alphaLayerFrame = bounds
        alphaLayerFrame.size.width *= CGFloat(progress)

        return alphaLayerFrame
    }

    private func setAlphaLayerFrame(for progress: Float, animated: Bool) {
        let frame = alphaLayerFrame(for: progress)

        let animationDuration: TimeInterval
        if animated {
            animationDuration = self.animationDuration
        } else {
            animationDuration = 0.0
        }

        alphaLayerFrame.value = AnimatedFrameUpdate(frame: frame,
                                                    animationDuration: animationDuration)
    }

    private func setProgress(_ progress: Float, shouldInformListeners: Bool) {
        let backedUpShouldInformListeners = self.shouldInformListeners
        defer {
            self.shouldInformListeners = backedUpShouldInformListeners
        }

        self.shouldInformListeners = shouldInformListeners

        self.progress = progress
    }

    // MARK: - Public methods

    /// Updates the gradient color list.
    ///
    /// Parameters:
    ///  - gradientColorList: New colors to be used as gradient colors.
    ///
    /// Note: This is just a public setter for hiding the oberservable implementation.
    func setGradientColorList(_ gradientColorList: [UIColor]) {
        self.gradientColorList.value = gradientColorList
    }

    /// Returns the colors, currently used for the gradient.
    ///
    /// Returns: Current gradient colors list.
    ///
    /// Note: This is just a public getter for hiding the oberservable implementation.
    func getGradientColorList() -> [UIColor] {
        return gradientColorList.value
    }

    /// Adjusts the current progress.
    func setProgress(_ progress: Float, animated: Bool) {
        // Keep track of our internal progress property without updating the view. E.g. if we rotate the device afterwards,
        // we have to adjust the frame to our current progress property.
        setProgress(progress, shouldInformListeners: false)

        setAlphaLayerFrame(for: progress, animated: animated)
    }
}
