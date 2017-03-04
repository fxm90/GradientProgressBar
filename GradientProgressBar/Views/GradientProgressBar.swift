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
    
    lazy private var gradientLayer: CAGradientLayer! = self.initGradientLayer()
    lazy private var alphaLayer: CALayer! = self.initAlphaLayer()
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        
        self.initColors()
        self.layer.insertSublayer(self.gradientLayer, at: 0)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initColors()
        self.layer.insertSublayer(self.gradientLayer, at: 0)
    }
    
    func initColors() {
        self.backgroundColor = GradientProgressBarDefaultValues.backgroundColor
        
        self.trackTintColor = UIColor.clear
        self.progressTintColor = UIColor.clear
    }
    
    // MARK: Lazy initializers
    
    func initGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        gradientLayer.anchorPoint = CGPoint(x: 0, y: 0)
        gradientLayer.position = CGPoint(x: 0, y: 0)
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0);
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0);
        
        gradientLayer.colors = GradientProgressBarDefaultValues.gradientColors
        
        gradientLayer.mask = self.alphaLayer
        
        return gradientLayer
    }
    
    func initAlphaLayer() -> CALayer {
        let alphaLayer = CALayer()
        alphaLayer.frame = self.bounds
        
        alphaLayer.anchorPoint = CGPoint(x: 0, y: 0)
        alphaLayer.position = CGPoint(x: 0, y: 0)
        
        alphaLayer.backgroundColor = UIColor.white.cgColor
        
        return alphaLayer
    }
    
    // MARK: Layout
    
    func updateAlphaLayerWidth() {
        self.alphaLayer.frame =
            self.bounds.sizeByPercentage(width: CGFloat(self.progress))
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.gradientLayer.frame = self.bounds
        self.updateAlphaLayerWidth()
    }
    
    override public func setProgress(_ progress: Float, animated: Bool) {
        super.setProgress(progress, animated: animated)
        
        self.updateAlphaLayerWidth()
    }
}
