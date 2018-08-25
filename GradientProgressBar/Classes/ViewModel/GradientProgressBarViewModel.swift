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
    // MARK: - Types

    struct AnimatedFrameUpdate: Equatable {
        static let zero = AnimatedFrameUpdate(frame: .zero, animationDuration: 0.0)

        let frame: CGRect
        let animationDuration: TimeInterval
    }

    // MARK: - Public properties

    ///
    let gradientLayerFrame: Observable<CGRect> = Observable(.zero)

    ///
    let alphaLayerFrame: Observable<AnimatedFrameUpdate> = Observable(.zero)

    /// Gradient colors for the progress view.
    let gradientColorList: Observable = Observable(GradientProgressBar.DefaultValues.gradientColorList)

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
    var animationDuration = GradientProgressBar.DefaultValues.animationDuration

    /// Animation timing function for animated progress change.
    var timingFunction = GradientProgressBar.DefaultValues.timingFunction

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

    ///
    ///
    /// Note: This is just a public setter for hiding the oberservable implementation.
    func setGradientColorList(_ gradientColorList: [UIColor]) {
        self.gradientColorList.value = gradientColorList
    }

    ///
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
