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

    /// Layer with the gradient.
    public private(set) var gradientLayer = CAGradientLayer()

    /// Alpha mask for visible part of gradient layer.
    public private(set) var alphaMaskLayer = CALayer()

    // MARK: - Public properties

    /// Gradient colors for the progress view.
    //
    /// Note:
    ///  - Has to be of type `UIColor` for Objective-C compability
    public var gradientColorList: [UIColor]? {
        didSet {
            updateGradientLayerColors()
        }
    }

    /// Animation duration for call to `setProgress(x, animated: true)`.
    public var animationDuration: TimeInterval?

    /// Animation timing function for call to `setProgress(x, animated: true)`.
    public var timingFunction: CAMediaTimingFunction?

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

        // Clear tint and progress colors, we'll use our `gradientLayer` for showing progress instead
        trackTintColor = .clear
        progressTintColor = .clear

        setupAlphaMaskLayer()
        setupGradientLayer()

        // After finished setting up, we'll apply the gradient colors. As these might already have been overwritten,
        // do not apply the gradient colors from default values!
        updateGradientLayerColors()

        layer.insertSublayer(gradientLayer, at: 0)
        updateAlphaMaskLayer()
    }

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

        // Apply `alphaMaskLayer"` as a mask to the gradient layer in order to show only the current "progress" of the `gradientLayer`.
        gradientLayer.mask = alphaMaskLayer
    }

    // MARK: - Update gradient

    private func updateGradientLayerColors() {
        let gradientColorList = self.gradientColorList ?? DefaultValues.gradientColorList
        gradientLayer.colors = gradientColorList.map({ $0.cgColor })
    }

    /// Updates the alpha mask of the gradient layer.
    ///
    /// Parameters:
    ///  - animated: `true` if the change should be animated, `false` if the change should happen immediately.
    private func updateAlphaMaskLayer(animated: Bool = false) {
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(timingFunction)

        if animated {
            let animationDuration = self.animationDuration ?? DefaultValues.animationDuration
            CATransaction.setAnimationDuration(animationDuration)
        } else {
            // Workaround for non animated progress change
            // Source: https://stackoverflow.com/a/16381287/3532505
            CATransaction.setAnimationDuration(0.0)
        }

        alphaMaskLayer.frame = bounds.update(widthByFactor: CGFloat(progress))

        CATransaction.commit()
    }

    override public func setProgress(_ progress: Float, animated: Bool) {
        super.setProgress(progress, animated: animated)

        updateAlphaMaskLayer(animated: animated)
    }
}
