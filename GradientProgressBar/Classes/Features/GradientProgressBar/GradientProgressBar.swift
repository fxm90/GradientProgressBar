//
//  GradientProgressBar.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 03/01/17.
//  Copyright © 2017 Felix Mau. All rights reserved.
//

import UIKit
import LightweightObservable

/// A customizable gradient progress bar (`UIProgressView`).
open class GradientProgressBar: UIProgressView {
    // MARK: - Public properties

    /// Gradient colors for the progress view.
    public var gradientColorList = UIColor.defaultGradientColorList {
        didSet {
            gradientLayer.colors = gradientColorList.cgColors
        }
    }

    /// Animation duration for calls to `setProgress(x, animated: true)`.
    public var animationDuration: TimeInterval {
        get {
            return viewModel.animationDuration
        }
        set {
            viewModel.animationDuration = newValue
        }
    }

    /// Animation timing function for calls to `setProgress(x, animated: true)`.
    public var timingFunction: CAMediaTimingFunction {
        get {
            return viewModel.timingFunction
        }
        set {
            viewModel.timingFunction = newValue
        }
    }

    open override var progress: Float {
        didSet {
            viewModel.setProgress(progress)
        }
    }

    // MARK: - Private properties

    /// Layer containing the gradient.
    private var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()

        layer.anchorPoint = .zero
        layer.startPoint = .zero
        layer.endPoint = CGPoint(x: 1.0, y: 0.0)

        return layer
    }()

    /// Alpha mask for showing only the visible "progress"-part of the gradient layer.
    private var alphaMaskLayer: CALayer = {
        let layer = CALayer()

        layer.anchorPoint = .zero
        layer.position = .zero
        layer.backgroundColor = UIColor.white.cgColor

        return layer
    }()

    /// View-model containing all logic related to the gradient view.
    private let viewModel = GradientProgressBarViewModel()

    /// The dispose bag for the observables.
    private var disposeBag = DisposeBag()

    // MARK: - Constructor

    public override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    // MARK: - Public methods

    open override func layoutSubviews() {
        super.layoutSubviews()

        // Unfortunately `CALayer` is not affected by autolayout, so any change in the size of the view will not change the gradient layer.
        // That's why we'll have to update the frame here manually.
        gradientLayer.frame = bounds

        // Inform the view-model about the changed bounds, so it can calculate a new frame for the alpha-layer for the current progress value.
        viewModel.bounds = bounds
    }

    open override func setProgress(_ progress: Float, animated: Bool) {
        super.setProgress(progress, animated: animated)

        viewModel.setProgress(progress, animated: animated)
    }

    // MARK: - Private methods

    private func commonInit() {
        setupProgressView()
        bindViewModelToView()
    }

    private func setupProgressView() {
        backgroundColor = .defaultBackgroundColor

        // Clear tint and progress colors, we'll use our `gradientLayer` for showing the progress instead.
        trackTintColor = .clear
        progressTintColor = .clear

        // Apply the mask to the gradient layer, in order to show only the current progress of the gradient.
        gradientLayer.mask = alphaMaskLayer
        gradientLayer.colors = gradientColorList.cgColors

        layer.insertSublayer(gradientLayer, at: 0)
    }

    private func bindViewModelToView() {
        viewModel.alphaLayerAnimatedFrameUpdate.subscribeDistinct { [weak self] newAlphaLayerAnimatedFrameUpdate, _ in
            self?.update(alphaLayerFrame: newAlphaLayerAnimatedFrameUpdate.frame,
                         animationDuration: newAlphaLayerAnimatedFrameUpdate.animationDuration)
        }.disposed(by: &disposeBag)
    }

    private func update(alphaLayerFrame: CGRect, animationDuration: TimeInterval) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setAnimationTimingFunction(viewModel.timingFunction)

        alphaMaskLayer.frame = alphaLayerFrame

        CATransaction.commit()
    }
}
