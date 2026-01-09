//
//  UIColor+GradientProgressBar.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 10.01.26.
//  Copyright © 2026 Felix Mau. All rights reserved.
//

import SwiftUI
import UIKit

public extension UIColor {

  /// Color related configuration values for `GradientProgressBar`.
  enum GradientProgressBar {

    /// Namespace for background color values.
    enum BackgroundColor {
      /// The default background color for the progress bar in light mode.
      public static let lightMode = #colorLiteral(red: 0.8980392157, green: 0.9137254902, blue: 0.9215686275, alpha: 1)

      /// The default background color for the progress bar in dark mode.
      public static let darkMode = #colorLiteral(red: 0.1725490196, green: 0.1882352941, blue: 0.1843137255, alpha: 1)
    }

    /// The default background color for the progress bar.
    public static let backgroundColor = UIColor {
      $0.userInterfaceStyle == .dark ? BackgroundColor.darkMode : BackgroundColor.lightMode
    }

    /// The default color palette for the gradient colors.
    ///
    /// Source: <https://codepen.io/marcobiedermann/pen/LExXWW>
    public static let gradientColors = [
      #colorLiteral(red: 0.2980392157, green: 0.8509803922, blue: 0.3921568627, alpha: 1), #colorLiteral(red: 0.3529411765, green: 0.7843137255, blue: 0.9803921569, alpha: 1), #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), #colorLiteral(red: 0.2039215686, green: 0.6666666667, blue: 0.862745098, alpha: 1), #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1), #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1),
    ]
  }
}

public extension Color {

  /// Color related configuration values for `GradientProgressBar`.
  ///
  /// - Note: Added in `UIColor` extension file, cause these values are derived from
  ///         to the UIKit configuration values to ensure consistency across both frameworks.
  enum GradientProgressBar {
    /// The default background color for the progress view.
    public static let backgroundColor =
      Color(UIColor.GradientProgressBar.backgroundColor)

    /// The default color palette for the gradient colors.
    public static let gradientColors =
      UIColor.GradientProgressBar.gradientColors.map(Color.init)
  }
}
