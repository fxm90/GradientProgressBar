//
//  GradientProgressBar.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 01.03.17.
//  Copyright © 2017 Felix Mau. All rights reserved.
//

import LightweightObservable
import UIKit

/// Protocol for managing a progress bar, as defined by `UIProgressView` from Apple.
/// To provide the same interface with `GradientProgressBar`, we're gonna make both classes conform to this protocol.
///
/// - SeeAlso: [Apple documentation for `UIProgressView`](https://apple.co/2HjwstS)
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

/// A customizable gradient progress view.
@IBDesignable
open class GradientProgressBar: UIView {

    // MARK: - Public properties

    /// Gradient colors for the progress view.
    public var gradientColors: [UIColor] {
        get { gradientLayerViewModel.gradientColors }
        set { gradientLayerViewModel.gradientColors = newValue }
    }

    /// Animation duration for calls to `setProgress(x, animated: true)`.
    public var animationDuration: TimeInterval {
        get { maskLayerViewModel.animationDuration }
        set { maskLayerViewModel.animationDuration = newValue }
    }

    /// Animation timing function for calls to `setProgress(x, animated: true)`.
    public var timingFunction: CAMediaTimingFunction {
        get { maskLayerViewModel.timingFunction }
        set { maskLayerViewModel.timingFunction = newValue }
    }

    /// Layer containing the gradient.
    public let gradientLayer = CAGradientLayer()
        .set(\.anchorPoint, to: .zero)
        .set(\.startPoint, to: .zero)
        .set(\.endPoint, to: CGPoint(x: 1, y: 0))

    /// Alpha mask for showing only the visible "progress"-part of the gradient layer.
    public let maskLayer = CALayer()
        .set(\.backgroundColor, to: UIColor.white.cgColor)

    // MARK: - Private properties

    /// View-model containing all logic related to the gradient-layer.
    private let gradientLayerViewModel = GradientLayerViewModel()

    /// View-model containing all logic related to the mask-layer.
    private let maskLayerViewModel = MaskLayerViewModel()

    /// The dispose bag for the observables.
    private var disposeBag = DisposeBag()

    // MARK: - Instance Lifecycle

    override public init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    // MARK: - Public methods

    override open func layoutSubviews() {
        super.layoutSubviews()

        // Unfortunately `CALayer` is not affected by autolayout, so any change in the size of the view will not change the gradient layer.
        // That's why we'll have to update the frame here manually.
        gradientLayer.frame = bounds

        // Inform the view-model about the changed bounds, so it can calculate a new frame for the mask-layer, based on the current progress value.
        maskLayerViewModel.bounds = bounds
    }

    // MARK: - Private methods

    private func commonInit() {
        setupProgressView()
        bindViewModelsToView()
    }

    private func setupProgressView() {
        backgroundColor = UIColor.GradientProgressBar.backgroundColor

        // Apply the mask to the gradient layer, in order to show only the current progress of the gradient.
        gradientLayer.mask = maskLayer
        layer.insertSublayer(gradientLayer, at: 0)
    }

    private func bindViewModelsToView() {
        gradientLayerViewModel.gradientLayerColors.subscribeDistinct { [weak self] newGradientLayerColors, _ in
            self?.gradientLayer.colors = newGradientLayerColors
        }.disposed(by: &disposeBag)

        maskLayerViewModel.maskLayerFrameAnimation.subscribeDistinct { [weak self] newMaskLayerFrameAnimation, _ in
            self?.animateMaskLayer(frame: newMaskLayerFrameAnimation.frame,
                                   duration: newMaskLayerFrameAnimation.duration,
                                   timingFunction: newMaskLayerFrameAnimation.timingFunction)
        }.disposed(by: &disposeBag)
    }

    private func animateMaskLayer(frame: CGRect, duration: TimeInterval, timingFunction: CAMediaTimingFunction) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        CATransaction.setAnimationTimingFunction(timingFunction)

        maskLayer.frame = frame

        CATransaction.commit()
    }
}

// MARK: - `UIProgressHandling` conformance

extension GradientProgressBar: UIProgressHandling {
    // MARK: - Public properties

    @IBInspectable
    open var progress: Float {
        get { maskLayerViewModel.progress }
        set { maskLayerViewModel.progress = newValue }
    }

    // MARK: - Public methods

    open func setProgress(_ progress: Float, animated: Bool) {
        maskLayerViewModel.setProgress(progress, animated: animated)
    }
}
