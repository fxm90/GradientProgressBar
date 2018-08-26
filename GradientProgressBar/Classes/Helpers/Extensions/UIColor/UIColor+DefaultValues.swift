//
//  UIColor+DefaultValues.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 26.08.18.
//

import UIKit

extension UIColor {
    /// Default background color for the progress view.
    static let defaultBackgroundColor = UIColor(hex: "#e5e9eb")

    /// Default gradient colors for the progress view.
    ///
    /// Note:
    ///  - Based on https://codepen.io/marcobiedermann/pen/LExXWW
    static let defaultGradientColorList = [
        UIColor(hex: "#4cd964"),
        UIColor(hex: "#5ac8fa"),
        UIColor(hex: "#007aff"),
        UIColor(hex: "#34aadc"),
        UIColor(hex: "#5856d6"),
        UIColor(hex: "#ff2d55")
    ]
}
