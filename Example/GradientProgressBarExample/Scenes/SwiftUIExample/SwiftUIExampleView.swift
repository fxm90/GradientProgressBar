//
//  SwiftUIExampleView.swift
//  GradientProgressBarExample
//
//  Created by Felix Mau on 10.01.26.
//  Copyright © 2026 Felix Mau. All rights reserved.
//

import GradientProgressBar
import SwiftUI

private enum Config {
  /// Value that the progress bar is increased / decreased on each button tap.
  static let progressDelta: Double = 0.1

  /// The custom animation duration we use.
  static let animationDuration: TimeInterval = 0.5

  /// The custom gradient colors we use.
  ///
  /// Source: <https://color.adobe.com/Pink-Flamingo-color-theme-10343714/>
  static let gradientColors = [
    #colorLiteral(red: 0.9490196078, green: 0.3215686275, blue: 0.431372549, alpha: 1), #colorLiteral(red: 0.9450980392, green: 0.4784313725, blue: 0.5921568627, alpha: 1), #colorLiteral(red: 0.9529411765, green: 0.737254902, blue: 0.7843137255, alpha: 1), #colorLiteral(red: 0.4274509804, green: 0.8666666667, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.9411764706, blue: 0.9568627451, alpha: 1),
  ].map(Color.init)
}

/// SwiftUI view showcasing the `gradientProgressBar` progress view style in SwiftUI.
/// Includes two examples: one with default gradient colors and one with custom gradient colors.
struct SwiftUIExampleView: View {
  var body: some View {
    NavigationStack {
      VStack(spacing: .space10) {
        DefaultGradientColorsExampleView()
        CustomGradientColorsExampleView()
      }
      .padding(.space6)
      .navigationTitle("📲 SwiftUI Example")
    }
  }
}

// MARK: - Supporting Types

private struct DefaultGradientColorsExampleView: View {

  @ScaledMetric(relativeTo: .body)
  private var buttonSize = 20

  @State
  private var progress = 0.7

  private var formattedProgress: String {
    progress.formatted(
      .percent.precision(.fractionLength(0)),
    )
  }

  var body: some View {
    VStack(alignment: .leading, spacing: .space2) {
      Text(
        """
        \(Text("Progress "))\
        \(Text(formattedProgress).fontWeight(.semibold))
        """,
      )
      .font(.callout)

      ProgressView(value: progress)
        .progressViewStyle(.gradientProgressBar)
        .animation(.easeInOut, value: progress)
        .frame(height: 3)
        .padding(.bottom, .space2)

      HStack(spacing: .space2) {
        Button {
          progress -= Config.progressDelta
        } label: {
          Image(sfSymbol: .minus)
            .frame(width: buttonSize, height: buttonSize)
        }
        .buttonStyle(.borderedProminent)
        .disabled(progress <= .ulpOfOne)
        .accessibilityLabel("Decrease progress")

        Spacer()

        Button {
          progress = 0.5
        } label: {
          Image(sfSymbol: .arrowCounterclockwise)
            .frame(width: buttonSize, height: buttonSize)
        }
        .buttonStyle(.borderedProminent)
        .accessibilityLabel("Reset progress")

        Spacer()

        Button {
          progress += Config.progressDelta
        } label: {
          Image(sfSymbol: .plus)
            .frame(width: buttonSize, height: buttonSize)
        }
        .buttonStyle(.borderedProminent)
        .disabled(progress > 1 - .ulpOfOne)
        .accessibilityLabel("Increase progress")
      }
    }
  }
}

private struct CustomGradientColorsExampleView: View {

  @ScaledMetric(relativeTo: .body)
  private var buttonSize = 20

  @State
  private var progress = 0.4

  private var formattedProgress: String {
    progress.formatted(
      .percent.precision(.fractionLength(0)),
    )
  }

  var body: some View {
    VStack(alignment: .leading, spacing: .space2) {
      Text(
        """
        \(Text("Progress "))\
        \(Text(formattedProgress).fontWeight(.semibold))
        """,
      )
      .font(.callout)

      ProgressView(value: progress)
        .progressViewStyle(
          .gradientProgressBar(
            gradientColors: Config.gradientColors,
          ),
        )
        .animation(.easeInOut(duration: Config.animationDuration), value: progress)
        .frame(height: 3)
        .padding(.bottom, .space2)

      HStack(spacing: .space2) {
        Button {
          progress -= Config.progressDelta
        } label: {
          Image(sfSymbol: .minus)
            .frame(width: buttonSize, height: buttonSize)
        }
        .buttonStyle(.borderedProminent)
        .disabled(progress <= .ulpOfOne)
        .accessibilityLabel("Decrease progress")

        Spacer()

        Button {
          progress = 0.5
        } label: {
          Image(sfSymbol: .arrowCounterclockwise)
            .frame(width: buttonSize, height: buttonSize)
        }
        .buttonStyle(.borderedProminent)
        .accessibilityLabel("Reset progress")

        Spacer()

        Button {
          progress += Config.progressDelta
        } label: {
          Image(sfSymbol: .plus)
            .frame(width: buttonSize, height: buttonSize)
        }
        .buttonStyle(.borderedProminent)
        .disabled(progress > 1 - .ulpOfOne)
        .accessibilityLabel("Increase progress")
      }
    }
  }
}

// MARK: - Preview

#Preview {
  SwiftUIExampleView()
}
