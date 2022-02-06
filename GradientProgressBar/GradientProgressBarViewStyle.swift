//
//  GradientProgressBarViewStyle.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 02.02.22.
//  Copyright © 2022 Felix Mau. All rights reserved.
//

import SwiftUI

///
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
    ///
    ///
    static var gradientProgressBar: Self {
        gradientProgressBar()
    }

    ///
    ///
    static func gradientProgressBar(backgroundColor: Color = GradientProgressBarViewStyle.Config.defaultBackgroundColor,
                                    gradientColors: [Color] = GradientProgressBarViewStyle.Config.defaultGradientColors,
                                    cornerRadius: Double = GradientProgressBarViewStyle.Config.defaultCornerRadius) -> Self {
        GradientProgressBarViewStyle(backgroundColor: backgroundColor,
                                     gradientColors: gradientColors,
                                     cornerRadius: cornerRadius)
    }
}
