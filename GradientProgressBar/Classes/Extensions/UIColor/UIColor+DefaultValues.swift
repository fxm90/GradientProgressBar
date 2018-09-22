//
//  UIColor+DefaultValues.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 26.08.18.
//

import UIKit

extension UIColor {
    /// Default background color for the progress view.
    static let defaultBackgroundColor = UIColor.CustomColors.grey

    /// Default gradient colors for the progress view.
    ///
    /// Note:
    ///  - Based on https://codepen.io/marcobiedermann/pen/LExXWW
    static let defaultGradientColorList = [
        UIColor.CustomColors.green,
        UIColor.CustomColors.blue.malibu,
        UIColor.CustomColors.blue.azure,
        UIColor.CustomColors.blue.curious,
        UIColor.CustomColors.violet,
        UIColor.CustomColors.red
    ]
}
