//
//  UIColor+DefaultValues.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 08/26/18.
//  Copyright © 2018 Felix Mau. All rights reserved.
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
