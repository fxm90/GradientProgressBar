//
//  GradientProgressBar.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 01.03.17.
//  Copyright © 2017 Felix Mau. All rights reserved.
//

import Foundation
import UIKit

public class GradientProgressBar : UIProgressView {
    
    private var alphaMaskLayer: CALayer = CALayer()
    private var gradientLayer:  CAGradientLayer = CAGradientLayer()
    
    // Workaround to handle orientation change, as "layoutSubviews()" gets triggered each time
    // the progress value is changed.
    override public var bounds: CGRect {
        didSet {
            updateAlphaMaskLayerWidth()
        }
    }
    
    // Update layer mask on direct changes to progress value.
    override public var progress: Float {
        didSet {
            updateAlphaMaskLayerWidth()
        }
    }
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        
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
    
    func setupProgressViewColors() {
        backgroundColor =
            GradientProgressBarDefaultValues.backgroundColor
        
        trackTintColor = .clear
        progressTintColor = .clear
    }
    
    // MARK: - Setup layers
    
    func setupAlphaMaskLayer()  {
        alphaMaskLayer.frame = bounds
        
        alphaMaskLayer.anchorPoint = CGPoint(x: 0, y: 0)
        alphaMaskLayer.position    = CGPoint(x: 0, y: 0)
        
        alphaMaskLayer.backgroundColor = UIColor.white.cgColor
    }
    
    func setupGradientLayer() {
        gradientLayer.frame = bounds
        
        gradientLayer.anchorPoint = CGPoint(x: 0, y: 0)
        gradientLayer.position    = CGPoint(x: 0, y: 0)
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 1.0, y: 0.0)
        
        gradientLayer.colors =
            GradientProgressBarDefaultValues.gradientColors
        
        // Apply "alphaMaskLayer" as a mask to the gradient layer in order to show only parts of the current "progress"
        gradientLayer.mask = alphaMaskLayer
    }
    
    // MARK: - Update gradient
    
    func updateAlphaMaskLayerWidth(animated: Bool = false) {
        CATransaction.begin()
        
        // Workaround for non animated progress change: Remove CALayer default animation duration of 0.25
        // Source: https://stackoverflow.com/a/16381287/3532505
        if !animated {
            CATransaction.setAnimationDuration(0.0)
        }
        
        alphaMaskLayer.frame =
            bounds.updateWidth(percentage: CGFloat(progress))
        
        CATransaction.commit()
    }
    
    override public func setProgress(_ progress: Float, animated: Bool) {
        super.setProgress(progress, animated: animated)
        
        updateAlphaMaskLayerWidth(
            animated: animated
        )
    }
}
