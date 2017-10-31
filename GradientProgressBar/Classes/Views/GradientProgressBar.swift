//
//  GradientProgressBar.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 01.03.17.
//  Copyright © 2017 Felix Mau. All rights reserved.
//

import Foundation
import UIKit

/// `UIProgressView` with a gradient.
open class GradientProgressBar: UIProgressView {

    /// Struct containing the default configuration.
    private struct DefaultValues {

        /// Background color for the progress view.
        static let backgroundColor = UIColor(hexString:"#e5e9eb")

        /// Gradient colors for the progress view.
        ///
        /// Note:
        ///  - Based on http://www.cssscript.com/ios-style-gradient-progress-bar-with-pure-css-css3/
        static let gradientColors = [
            UIColor(hexString:"#4cd964").cgColor,
            UIColor(hexString:"#5ac8fa").cgColor,
            UIColor(hexString:"#007aff").cgColor,
            UIColor(hexString:"#34aadc").cgColor,
            UIColor(hexString:"#5856d6").cgColor,
            UIColor(hexString:"#ff2d55").cgColor
        ]

        /// Animation duration for call to `setProgress(x, animated: true)`.
        ///
        /// Note: Equals to CALayer default animation duration
        static let animationDuration = 0.25
    }

    /// Layer with the gradient .
    open var gradientLayer = CAGradientLayer()

    /// Alpha mask for visible part of gradient layer.
    public private(set) var alphaMaskLayer = CALayer()

    /// Animation duration for call to `setProgress(x, animated: true)`.
    open var animationDuration = DefaultValues.animationDuration

    /// The bounds rectangle, which describes the view’s location and size in its own coordinate system.
    override open var bounds: CGRect {
        didSet {
            // Workaround to handle orientation change, as `layoutSubviews()` gets triggered each time
            // the progress value is changed.
            alphaMaskLayer.frame = bounds
            gradientLayer.frame = bounds

            updateAlphaMaskLayerWidth()
        }
    }

    /// The current progress.
    override open var progress: Float {
        didSet {
            // Update layer mask on direct changes to progress value.
            updateAlphaMaskLayerWidth()
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
        backgroundColor =
            DefaultValues.backgroundColor

        // Clear tint and progress colors, we'll use the gradient layer for showing progress instead
        trackTintColor = .clear
        progressTintColor = .clear

        setupAlphaMaskLayer()
        setupGradientLayer()

        layer.insertSublayer(gradientLayer, at: 0)
        updateAlphaMaskLayerWidth()
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

        gradientLayer.colors =
            DefaultValues.gradientColors

        // Apply "alphaMaskLayer" as a mask to the gradient layer in order to show only parts of the current "progress"
        gradientLayer.mask = alphaMaskLayer
    }

    // MARK: - Update gradient

    /// Updates the alpha mask of the gradient layer.
    ///
    /// Parameters:
    ///  - animated: `true` if the change should be animated, `false` if the change should happen immediately.
    open func updateAlphaMaskLayerWidth(animated: Bool = false) {
        CATransaction.begin()

        // Workaround for non animated progress change
        // Source: https://stackoverflow.com/a/16381287/3532505
        CATransaction.setAnimationDuration(
            animated ? animationDuration : 0.0
        )

        alphaMaskLayer.frame =
            bounds.updateWidth(byFactor: CGFloat(progress))

        CATransaction.commit()
    }

    override open func setProgress(_ progress: Float, animated: Bool) {
        super.setProgress(progress, animated: animated)

        updateAlphaMaskLayerWidth(
            animated: animated
        )
    }
}
