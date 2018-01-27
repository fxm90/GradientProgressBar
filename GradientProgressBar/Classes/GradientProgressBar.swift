//
//  GradientProgressBar.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 01.03.17.
//  Copyright © 2017 Felix Mau. All rights reserved.
//

import UIKit

/// `UIProgressView` with a customizable gradient.
public class GradientProgressBar: UIProgressView {

    // MARK: - Types

    /// Struct containing the default configuration.
    struct DefaultValues {

        /// Default background color for the progress view.
        static let backgroundColor = UIColor(hex: "#e5e9eb")

        /// Default gradient colors for the progress view.
        ///
        /// Note:
        ///  - Based on https://codepen.io/marcobiedermann/pen/LExXWW
        static let gradientColorList = [
            UIColor(hex: "#4cd964"),
            UIColor(hex: "#5ac8fa"),
            UIColor(hex: "#007aff"),
            UIColor(hex: "#34aadc"),
            UIColor(hex: "#5856d6"),
            UIColor(hex: "#ff2d55")
        ]

        /// Default animation duration for call to `setProgress(x, animated: true)`.
        ///
        /// Note: Equals to CALayer default animation duration
        static let animationDuration = 0.25
    }

    // MARK: - Private properties

    /// Viewmodel containing logic for gradient view.
    private var viewModel = GradientProgressBarViewModel()

    /// Layer containing the gradient.
    private var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()

        layer.anchorPoint = CGPoint(x: 0, y: 0)
        layer.position = CGPoint(x: 0, y: 0)

        layer.startPoint = CGPoint(x: 0.0, y: 0.0)
        layer.endPoint = CGPoint(x: 1.0, y: 0.0)

        return layer
    }()

    /// Alpha mask for showing only "progress"-part of gradient layer.
    private var alphaMaskLayer: CALayer = {
        let layer = CALayer()

        layer.anchorPoint = CGPoint(x: 0, y: 0)
        layer.position = CGPoint(x: 0, y: 0)
        layer.backgroundColor = UIColor.white.cgColor

        return layer
    }()

    // MARK: - Public properties

    /// Gradient colors for the progress view.
    //
    /// Note:
    ///  - Has to be of type `UIColor` for Objective-C compability
    public var gradientColorList: [UIColor]? {
        get {
            return viewModel.gradientColorList
        }
        set {
            viewModel.gradientColorList = newValue
        }
    }

    /// Animation duration for call to `setProgress(x, animated: true)`.
    public var animationDuration: TimeInterval? {
        get {
            return viewModel.animationDuration
        }
        set {
            viewModel.animationDuration = newValue
        }
    }

    /// Animation timing function for call to `setProgress(x, animated: true)`.
    public var timingFunction: CAMediaTimingFunction? {
        get {
            return viewModel.timingFunction
        }
        set {
            viewModel.timingFunction = newValue
        }
    }

    public override var bounds: CGRect {
        didSet {
            viewModel.bounds = bounds
        }
    }

    public override var progress: Float {
        didSet {
            viewModel.progress = progress
        }
    }

    // MARK: - Initializers

    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupProgressView()
        setupViewModel()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupProgressView()
        setupViewModel()
    }

    private func setupProgressView() {
        backgroundColor = DefaultValues.backgroundColor

        // Clear tint and progress colors, we'll use our `gradientLayer` for showing progress instead
        trackTintColor = .clear
        progressTintColor = .clear

        // Apply mask to the gradient layer in order to show only the current "progress" of the gradient.
        gradientLayer.mask = alphaMaskLayer

        layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.setup(forBounds: bounds)
    }

    // MARK: - Public methods

    public override func setProgress(_ progress: Float, animated: Bool) {
        super.setProgress(progress, animated: animated)

        viewModel.setProgress(progress, animated: animated)
    }
}

// MARK: - GradientProgressBarViewModelDelegate

extension GradientProgressBar: GradientProgressBarViewModelDelegate {
    func viewModel(_: GradientProgressBarViewModel, didUpdateAlphaLayerFrame frame: CGRect,
                   animationDuration: TimeInterval?, timingFunction: CAMediaTimingFunction?) {
        guard let animationDuration = animationDuration, animationDuration > 0.0 else {
            // We didn't get any (valid) duration so update frame immediately
            alphaMaskLayer.frame = frame
            return
        }

        CATransaction.begin()
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setAnimationTimingFunction(timingFunction)

        alphaMaskLayer.frame = frame

        CATransaction.commit()
    }

    func viewModel(_: GradientProgressBarViewModel, didUpdateGradientLayerFrame frame: CGRect) {
        gradientLayer.frame = frame
    }

    func viewModel(_: GradientProgressBarViewModel, didUpdateGradientLayerColorList colorList: [UIColor]) {
        gradientLayer.colors = colorList.map({ $0.cgColor })
    }
}
