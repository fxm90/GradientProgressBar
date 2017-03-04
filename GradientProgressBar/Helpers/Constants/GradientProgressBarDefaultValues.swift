//
//  GradientProgressBarDefaultValues.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 28.02.17.
//  Copyright © 2017 Felix Mau. All rights reserved.
//

import Foundation
import UIKit

public struct GradientProgressBarDefaultValues {
    
    public static let backgroundColor : UIColor = UIColor(hexString:"#e5e9eb")
    
    // iOS color palette
    // From: http://www.cssscript.com/ios-style-gradient-progress-bar-with-pure-css-css3/
    public static let gradientColors : GradientColors = [
        UIColor(hexString:"#4cd964").cgColor,
        UIColor(hexString:"#5ac8fa").cgColor,
        UIColor(hexString:"#007aff").cgColor,
        UIColor(hexString:"#34aadc").cgColor,
        UIColor(hexString:"#5856d6").cgColor,
        UIColor(hexString:"#ff2d55").cgColor
    ]
}
