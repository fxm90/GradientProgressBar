//
//  GradientProgressBarSnapshotTests.swift
//  GradientProgressBarTests
//
//  Created by Felix Mau on 07.11.19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import Foundation
import SnapshotTesting
import Testing
import UIKit
@testable import GradientProgressBar

/// - Note: For more readable reference file names, we don't use raw identifiers for test names here.
@MainActor
@Suite
struct GradientProgressBarSnapshotTests {

  // MARK: - Config

  private enum Config {
    /// The frame we use for rendering the `GradientProgressBar`.
    /// This will also be the image size of our reference image.
    static let frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 3.0)

    /// The custom colors we use on this test-case.
    ///
    /// Source: <https://color.adobe.com/Pink-Flamingo-color-theme-10343714/>
    static let gradientColors = [
      #colorLiteral(red: 0.9490196078, green: 0.3215686275, blue: 0.431372549, alpha: 1), #colorLiteral(red: 0.9450980392, green: 0.4784313725, blue: 0.5921568627, alpha: 1), #colorLiteral(red: 0.9529411765, green: 0.737254902, blue: 0.7843137255, alpha: 1), #colorLiteral(red: 0.4274509804, green: 0.8666666667, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.9411764706, blue: 0.9568627451, alpha: 1),
    ]

    static let lightTraitCollection = UITraitCollection(userInterfaceStyle: .light)
    static let darkTraitCollection = UITraitCollection(userInterfaceStyle: .dark)
  }

  // MARK: - Test `.light` User Interface Style

  @Test
  func gradientProgressBar_withZeroPercentProgress_andLightTraitCollection() {
    // Given
    let gradientProgressBar = GradientProgressBar(frame: Config.frame)

    // When
    gradientProgressBar.progress = 0.0

    // Then
    assertSnapshot(of: gradientProgressBar, as: .image(traits: Config.lightTraitCollection))
  }

  @Test
  func gradientProgressBar_with50PercentProgress_andLightTraitCollection() {
    // Given
    let gradientProgressBar = GradientProgressBar(frame: Config.frame)

    // When
    gradientProgressBar.progress = 0.5

    // Then
    assertSnapshot(of: gradientProgressBar, as: .image(traits: Config.lightTraitCollection))
  }

  @Test
  func gradientProgressBar_with100PercentProgress_andLightTraitCollection() {
    // Given
    let gradientProgressBar = GradientProgressBar(frame: Config.frame)

    // When
    gradientProgressBar.progress = 1.0

    // Then
    assertSnapshot(of: gradientProgressBar, as: .image(traits: Config.lightTraitCollection))
  }

  // MARK: - Test `.dark` User Interface Style

  @Test
  func gradientProgressBar_withZeroPercentProgress_andDarkTraitCollection() {
    // Given
    let gradientProgressBar = GradientProgressBar(frame: Config.frame)

    // When
    gradientProgressBar.progress = 0.0

    // Then
    assertSnapshot(of: gradientProgressBar, as: .image(traits: Config.darkTraitCollection))
  }

  @Test
  func gradientProgressBar_with50PercentProgress_andDarkTraitCollection() {
    // Given
    let gradientProgressBar = GradientProgressBar(frame: Config.frame)

    // When
    gradientProgressBar.progress = 0.5

    // Then
    assertSnapshot(of: gradientProgressBar, as: .image(traits: Config.darkTraitCollection))
  }

  @Test
  func gradientProgressBar_with100PercentProgress_andDarkTraitCollection() {
    // Given
    let gradientProgressBar = GradientProgressBar(frame: Config.frame)

    // When
    gradientProgressBar.progress = 1.0

    // Then
    assertSnapshot(of: gradientProgressBar, as: .image(traits: Config.darkTraitCollection))
  }

  // MARK: - Test Property `gradientColors`

  @Test
  func gradientProgressBar_withZeroPercentProgress_andCustomGradientColors() {
    // Given
    let gradientProgressBar = GradientProgressBar(frame: Config.frame)
    gradientProgressBar.gradientColors = Config.gradientColors

    // When
    gradientProgressBar.progress = 0.0

    // Then
    assertSnapshot(of: gradientProgressBar, as: .image(traits: Config.lightTraitCollection))
  }

  @Test
  func gradientProgressBar_with50PercentProgress_andCustomGradientColors() {
    // Given
    let gradientProgressBar = GradientProgressBar(frame: Config.frame)
    gradientProgressBar.gradientColors = Config.gradientColors

    // When
    gradientProgressBar.progress = 0.5

    // Then
    assertSnapshot(of: gradientProgressBar, as: .image(traits: Config.lightTraitCollection))
  }

  @Test
  func gradientProgressBar_with100PercentProgress_andCustomGradientColors() {
    // Given
    let gradientProgressBar = GradientProgressBar(frame: Config.frame)
    gradientProgressBar.gradientColors = Config.gradientColors

    // When
    gradientProgressBar.progress = 1.0

    // Then
    assertSnapshot(of: gradientProgressBar, as: .image(traits: Config.lightTraitCollection))
  }
}
