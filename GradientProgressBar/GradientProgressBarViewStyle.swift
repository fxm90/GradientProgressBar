//
//  GradientProgressBarViewStyle.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 02.02.22.
//  Copyright © 2022 Felix Mau. All rights reserved.
//

import SwiftUI

/// A `ProgressViewStyle` showing a gradient.
///
/// - Note: Requires **iOS 15**, due to the view-modifier `mask(alignment:_:)`.
@available(iOS 15.0, *)
public struct GradientProgressBarViewStyle: ProgressViewStyle {
    // MARK: - Config

    public enum Config {
        public static let defaultBackgroundColor = Color(UIColor.GradientProgressBar.backgroundColor)
        public static let defaultGradientColors = UIColor.GradientProgressBar.gradientColors.map(Color.init)
        public static let defaultCornerRadius: Double = 2
    }

    // MARK: - Public properties

    let backgroundColor: Color
    let gradientColors: [Color]
    let cornerRadius: Double

    // MARK: - Public methods

    public func makeBody(configuration: Configuration) -> some View {
        GeometryReader { proxy in
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)

                LinearGradient(colors: gradientColors, startPoint: .leading, endPoint: .trailing)
                    .mask(alignment: .leading) {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .frame(width: (configuration.fractionCompleted ?? 0) * proxy.size.width)
                    }
            }
        }
    }
}

// MARK: - Helpers

@available(iOS 15.0, *)
public extension ProgressViewStyle where Self == GradientProgressBarViewStyle {
    /// Syntactic sugar for returning an instance of the `GradientProgressBarViewStyle`
    /// with the **default parameters**.
    static var gradientProgressBar: Self {
        gradientProgressBar()
    }

    /// Syntactic sugar for returning an instance of the `GradientProgressBarViewStyle`.
    ///
    /// - Parameters:
    ///  - backgroundColor: The background-color to be used (clipped by a possible `cornerRadius`)
    ///  - gradientColors: The gradient-colors to be applied.
    ///  - cornerRadius: The corner-radius used on the background and the progress bar.
    static func gradientProgressBar(backgroundColor: Color = GradientProgressBarViewStyle.Config.defaultBackgroundColor,
                                    gradientColors: [Color] = GradientProgressBarViewStyle.Config.defaultGradientColors,
                                    cornerRadius: Double = GradientProgressBarViewStyle.Config.defaultCornerRadius) -> Self {
        GradientProgressBarViewStyle(backgroundColor: backgroundColor,
                                     gradientColors: gradientColors,
                                     cornerRadius: cornerRadius)
    }
}
