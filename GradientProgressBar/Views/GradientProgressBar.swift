//
//  GradientProgressBar.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 01.03.17.
//  Copyright © 2017 Felix Mau. All rights reserved.
//

import Foundation
import UIKit

open class GradientProgressBar: UIProgressView {

    private struct DefaultValues {
        static let backgroundColor = UIColor(hexString:"#e5e9eb")

        // iOS color palette
        // From: http://www.cssscript.com/ios-style-gradient-progress-bar-with-pure-css-css3/
        static let gradientColors = [
            UIColor(hexString:"#4cd964").cgColor,
            UIColor(hexString:"#5ac8fa").cgColor,
            UIColor(hexString:"#007aff").cgColor,
            UIColor(hexString:"#34aadc").cgColor,
            UIColor(hexString:"#5856d6").cgColor,
            UIColor(hexString:"#ff2d55").cgColor
        ]

        static let animationDuration = 0.25 // CALayer default animation duration
    }

    // Alpha mask for visible part of gradient.
    private var alphaMaskLayer: CALayer = CALayer()

    // Gradient layer.
    open var gradientLayer: CAGradientLayer = CAGradientLayer()

    // Duration for "setProgress(animated: true)"
    open var animationDuration = DefaultValues.animationDuration

    // Workaround to handle orientation change, as "layoutSubviews()" gets triggered each time
    // the progress value is changed.
    override open var bounds: CGRect {
        didSet {
            updateAlphaMaskLayerWidth()
        }
    }

    // Update layer mask on direct changes to progress value.
    override open var progress: Float {
        didSet {
            updateAlphaMaskLayerWidth()
        }
    }

    // MARK: - Initializers

    override public init(frame: CGRect) {
        super.init(frame: frame)

        setupProgressViewColors()
        setupAlphaMaskLayer()
        setupGradientLayer()

        layer.insertSublayer(gradientLayer, at: 0)
        updateAlphaMaskLayerWidth()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupProgressViewColors()
        setupAlphaMaskLayer()
        setupGradientLayer()

        layer.insertSublayer(gradientLayer, at: 0)
        updateAlphaMaskLayerWidth()
    }

    // MARK: - Setup UIProgressView

    private func setupProgressViewColors() {
        backgroundColor =
            DefaultValues.backgroundColor

        trackTintColor = .clear
        progressTintColor = .clear
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

    open func updateAlphaMaskLayerWidth(animated: Bool = false) {
        CATransaction.begin()

        // Workaround for non animated progress change
        // Source: https://stackoverflow.com/a/16381287/3532505
        CATransaction.setAnimationDuration(
            animated ? animationDuration : 0.0
        )

        alphaMaskLayer.frame =
            bounds.updateWidth(byPercentage: CGFloat(progress))

        CATransaction.commit()
    }

    override open func setProgress(_ progress: Float, animated: Bool) {
        super.setProgress(progress, animated: animated)

        updateAlphaMaskLayerWidth(
            animated: animated
        )
    }
}
