//
//  UIColor+MakeDynamicColor.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 22/09/19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import UIKit

// Source: https://gist.github.com/fxm90/fd217b463222afd6eabcb006fb26d92e
extension UIColor {
    /// Creates an instance of `UIColor`, that generates its color data dynamically based on the current `userInterfaceStyle`.
    /// Furthermore this method handles a fallback for iOS versions prior to iOS 13.
    ///
    /// - Parameters:
    ///   - lightVariant: The color variant used in light mode and for iOS versions prior to iOS 13.
    ///   - darkVariant: The color variant used in dark mode.
    ///
    /// - Returns: Instance of UIColor.
    static func makeDynamicColor(lightVariant: UIColor, darkVariant: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            // Prior to iOS 13 there was no dark-mode, so we`re gonna return the light variant.
            return lightVariant
        }

        return UIColor { (traitCollection: UITraitCollection) -> UIColor in
            traitCollection.userInterfaceStyle == .dark
                ? darkVariant
                : lightVariant
        }
    }
}
