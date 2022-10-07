//
//  Constants.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 26.08.19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import UIKit

public extension UIColor {
    /// Default colors for components.
    enum GradientProgressBar {
        /// Default background color for the progress view in light mode.
        static let backgroundColorForLightMode = #colorLiteral(red: 0.8980392157, green: 0.9137254902, blue: 0.9215686275, alpha: 1)

        /// Default background color for the progress view in dark mode.
        static let backgroundColorForDarkMode = #colorLiteral(red: 0.1725490196, green: 0.1882352941, blue: 0.1843137255, alpha: 1)

        /// Default background color for the progress view.
        static let backgroundColor = UIColor {
            $0.userInterfaceStyle == .dark ? backgroundColorForDarkMode : backgroundColorForLightMode
        }

        /// The default color palette for the gradient colors.
        ///
        /// - SeeAlso: https://codepen.io/marcobiedermann/pen/LExXWW
        public static let gradientColors = [
            #colorLiteral(red: 0.2980392157, green: 0.8509803922, blue: 0.3921568627, alpha: 1), #colorLiteral(red: 0.3529411765, green: 0.7843137255, blue: 0.9803921569, alpha: 1), #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), #colorLiteral(red: 0.2039215686, green: 0.6666666667, blue: 0.862745098, alpha: 1), #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1), #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1),
        ]
    }
}

public extension TimeInterval {
    /// Numeric default values.
    enum GradientProgressBar {
        /// Default animation duration for calls to `setProgress(x, animated: true)`.
        ///
        /// - Note: Equals to `CALayer` default animation duration (https://apple.co/2PVTCsB).
        static let progressAnimationDuration = 0.25
    }
}

public extension CAMediaTimingFunction {
    /// Default animation timing functions.
    enum GradientProgressBar {
        /// Default animation timing function for calls to `setProgress(x, animated: true)`.
        static let progressAnimationFunction = CAMediaTimingFunction(name: .default)
    }
}
