//
//  GradientProgressBar.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 01.03.17.
//  Copyright © 2017 Felix Mau. All rights reserved.
//

import UIKit
import Observable

/// `UIProgressView` with a customizable gradient.
public class GradientProgressBar: UIProgressView {
    // MARK: - Public properties

    /// Gradient colors for the progress view.
    public var gradientColorList: [UIColor] {
        get {
            return viewModel.getGradientColorList()
        }
        set {
            viewModel.setGradientColorList(newValue)
        }
    }

    /// Animation duration for call to `setProgress(x, animated: true)`.
    public var animationDuration: TimeInterval {
        get {
            return viewModel.animationDuration
        }
        set {
            viewModel.animationDuration = newValue
        }
    }

    /// Animation timing function for call to `setProgress(x, animated: true)`.
    public var timingFunction: CAMediaTimingFunction {
        get {
            return viewModel.timingFunction
        }
        set {
            viewModel.timingFunction = newValue
        }
    }

    public override var bounds: CGRect {
        didSet {
            // Workaround to handle orientation change, as `layoutSubviews()` gets triggered each time
            // the progress value is changed.
            viewModel.bounds = bounds
        }
    }

    public override var progress: Float {
        didSet {
            viewModel.progress = progress
        }
    }

    // MARK: - Private properties

    /// Viewmodel containing logic for gradient view.
    private var viewModel = GradientProgressBarViewModel()

    /// The dispose bag for the observables.
    private var disposal = Disposal()

    /// Layer containing the gradient.
    private var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()

        layer.anchorPoint = .zero
        layer.startPoint = .zero
        layer.endPoint = CGPoint(x: 1.0, y: 0.0)

        return layer
    }()

    /// Alpha mask for showing only visible "progress"-part of gradient layer.
    private var alphaMaskLayer: CALayer = {
        let layer = CALayer()

        layer.anchorPoint = .zero
        layer.position = .zero
        layer.backgroundColor = UIColor.white.cgColor

        return layer
    }()

    // MARK: - Constructor

    public override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    private func commonInit() {
        setupProgressView()

        // Initialize / update view model with current properties.
        viewModel.bounds = bounds
        viewModel.progress = progress

        bindViewModelToView()
    }

    // MARK: - Private methods

    private func setupProgressView() {
        backgroundColor = .defaultBackgroundColor

        // Clear tint and progress colors, we'll use our `gradientLayer` for showing progress instead.
        trackTintColor = .clear
        progressTintColor = .clear

        layer.insertSublayer(gradientLayer, at: 0)

        // Apply mask to the gradient layer in order to show only the current "progress" of the gradient.
        gradientLayer.mask = alphaMaskLayer
    }

    private func bindViewModelToView() {
        viewModel.gradientLayerFrame.observeDistinct { [weak self] nextValue, _ in
            self?.update(gradientLayerFrame: nextValue)
        }.add(to: &disposal)

        viewModel.alphaLayerFrame.observeDistinct { [weak self] nextValue, _ in
            self?.update(alphaLayerFrame: nextValue.frame,
                         animationDuration: nextValue.animationDuration)
        }.add(to: &disposal)

        viewModel.gradientColorList.observeDistinct { [weak self] nextValue, _ in
            self?.update(gradientColorList: nextValue)
        }.add(to: &disposal)
    }

    private func update(gradientLayerFrame: CGRect) {
        gradientLayer.frame = gradientLayerFrame
    }

    private func update(alphaLayerFrame: CGRect, animationDuration: TimeInterval) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setAnimationTimingFunction(viewModel.timingFunction)

        alphaMaskLayer.frame = alphaLayerFrame

        CATransaction.commit()
    }

    private func update(gradientColorList: [UIColor]) {
        gradientLayer.colors = gradientColorList.map({ $0.cgColor })
    }

    // MARK: - Public methods

    public override func setProgress(_ progress: Float, animated: Bool) {
        super.setProgress(progress, animated: animated)

        viewModel.setProgress(progress, animated: animated)
    }
}
