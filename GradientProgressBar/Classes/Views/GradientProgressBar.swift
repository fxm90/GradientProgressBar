//
//  GradientProgressBar.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 01.03.17.
//  Copyright © 2017 Felix Mau. All rights reserved.
//

import UIKit

/// `UIProgressView` with a gradient.
public class GradientProgressBar: UIProgressView {

    // MARK: - Types

    /// Struct containing the default configuration.
    private struct DefaultValues {

        /// Default background color for the progress view.
        static let backgroundColor = UIColor(hexString:"#e5e9eb")

        /// Default gradient colors for the progress view.
        ///
        /// Note:
        ///  - Has to be of type `UIColor` for Objective-C compability
        ///  - Based on http://www.cssscript.com/ios-style-gradient-progress-bar-with-pure-css-css3/
        static let gradientColors = [
            UIColor(hexString:"#4cd964"),
            UIColor(hexString:"#5ac8fa"),
            UIColor(hexString:"#007aff"),
            UIColor(hexString:"#34aadc"),
            UIColor(hexString:"#5856d6"),
            UIColor(hexString:"#ff2d55")
        ]

        /// Animation duration for call to `setProgress(x, animated: true)`.
        ///
        /// Note: Equals to CALayer default animation duration
        static let animationDuration = 0.25
    }

    // MARK: - Private properties

    /// Layer with the gradient.
    public private(set) var gradientLayer = CAGradientLayer()

    /// Alpha mask for visible part of gradient layer.
    public private(set) var alphaMaskLayer = CALayer()

    // MARK: - Public properties

    /// Gradient colors for the progress view.
    public var gradientColors = DefaultValues.gradientColors

    /// Animation duration for call to `setProgress(x, animated: true)`.
    public var animationDuration = DefaultValues.animationDuration

    override public var bounds: CGRect {
        didSet {
            // Workaround to handle orientation change, as `layoutSubviews()` gets triggered each time
            // the progress value is changed.
            alphaMaskLayer.frame = bounds
            gradientLayer.frame = bounds

            updateAlphaMaskLayer()
        }
    }

    override public var progress: Float {
        didSet {
            // Update layer mask on direct changes to progress value.
            updateAlphaMaskLayer()
        }
    }

    // MARK: - Initializers

    override public init(frame: CGRect) {
        super.init(frame: frame)

        setupProgressView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupProgressView()
    }

    // MARK: - Setup UIProgressView

    private func setupProgressView() {
        backgroundColor = DefaultValues.backgroundColor

        // Clear tint and progress colors, we'll use the gradient layer for showing progress instead
        trackTintColor = .clear
        progressTintColor = .clear

        setupAlphaMaskLayer()
        setupGradientLayer()

        layer.insertSublayer(gradientLayer, at: 0)
        updateAlphaMaskLayer()
    }

    // MARK: - Setup layers

    private func setupAlphaMaskLayer() {
        alphaMaskLayer.frame = bounds

        alphaMaskLayer.anchorPoint = CGPoint(x: 0, y: 0)
        alphaMaskLayer.position    = CGPoint(x: 0, y: 0)

        alphaMaskLayer.backgroundColor = UIColor.white.cgColor
    }

    private func setupGradientLayer() {
        gradientLayer.frame = bounds

        gradientLayer.anchorPoint = CGPoint(x: 0, y: 0)
        gradientLayer.position    = CGPoint(x: 0, y: 0)

        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 1.0, y: 0.0)

        gradientLayer.colors = gradientColors.map({ $0.cgColor })

        // Apply "alphaMaskLayer" as a mask to the gradient layer in order to show only parts of the current "progress"
        gradientLayer.mask = alphaMaskLayer
    }

    // MARK: - Update gradient

    /// Updates the alpha mask of the gradient layer.
    ///
    /// Parameters:
    ///  - animated: `true` if the change should be animated, `false` if the change should happen immediately.
    private func updateAlphaMaskLayer(animated: Bool = false) {
        CATransaction.begin()

        // Workaround for non animated progress change
        // Source: https://stackoverflow.com/a/16381287/3532505
        CATransaction.setAnimationDuration(
            animated ? animationDuration : 0.0
        )

        alphaMaskLayer.frame = bounds.update(widthByFactor: CGFloat(progress))

        CATransaction.commit()
    }

    override public func setProgress(_ progress: Float, animated: Bool) {
        super.setProgress(progress, animated: animated)

        updateAlphaMaskLayer(animated: animated)
    }
}
