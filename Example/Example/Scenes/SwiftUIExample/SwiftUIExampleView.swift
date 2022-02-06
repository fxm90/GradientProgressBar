//
//  SwiftUIExampleView.swift
//  Example
//
//  Created by Felix Mau on 02.02.22.
//  Copyright © 2022 Felix Mau. All rights reserved.
//

import SwiftUI
import GradientProgressBar

struct SwiftUIExampleView: View {
    // MARK: - Config

    private enum Config {
        /// Value that the progress bar is increased by on each tap on button.
        static let increaseValue: Double = 0.1

        // The animation we use to update the progress bar.
        static let animation: Animation = .easeInOut(duration: 0.25)

        /// The custom gradient colors we use (<https://color.adobe.com/Pink-Flamingo-color-theme-10343714/>).
        static let gradientColors = [
            #colorLiteral(red: 0.9490196078, green: 0.3215686275, blue: 0.431372549, alpha: 1), #colorLiteral(red: 0.9450980392, green: 0.4784313725, blue: 0.5921568627, alpha: 1), #colorLiteral(red: 0.9529411765, green: 0.737254902, blue: 0.7843137255, alpha: 1), #colorLiteral(red: 0.4274509804, green: 0.8666666667, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.9411764706, blue: 0.9568627451, alpha: 1),
        ].map(Color.init)

        /// The custom background color we use.
        static let backgroundColor: Color = .gray.opacity(0.05)
    }

    // MARK: - Private properties

    @State
    private var progress = 0.5

    // MARK: - Render

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                ProgressView(value: progress, total: 1)
                    .progressViewStyle(.gradientProgressBar)
                    .frame(height: 4)

                Divider()

                ProgressView(value: progress, total: 1)
                    .progressViewStyle(
                        .gradientProgressBar(backgroundColor: Config.backgroundColor,
                                             gradientColors: Config.gradientColors,
                                             cornerRadius: 4)
                    )
                    .frame(height: 8)
            }
            .padding()

            HStack {
                Button {
                    withAnimation(Config.animation) {
                        progress += Config.increaseValue
                    }
                } label: {
                    ImageTitleView(systemImageName: "timer",
                                   title: "Animate")
                }
                .frame(maxWidth: .infinity)

                Button {
                    progress += Config.increaseValue
                } label: {
                    ImageTitleView(systemImageName: "gearshape.2.fill",
                                   title: "Set Progress")
                }
                .frame(maxWidth: .infinity)

                Button {
                    progress = 0
                } label: {
                    ImageTitleView(systemImageName: "arrow.counterclockwise",
                                   title: "Reset")
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .frame(maxHeight: .infinity)
        .navigationTitle("🎨 SwiftUI Example")
    }
}

// MARK: - Subviews

private struct ImageTitleView: View {
    let systemImageName: String
    let title: String

    var body: some View {
        HStack {
            Image(systemName: systemImageName)
            Text(title)
                .lineLimit(1)
        }
    }
}

// MARK: - Preview

struct SwiftUIExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIExampleView()
    }
}
