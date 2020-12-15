//
//  CustomColorSnapshotTestCase.swift
//  GradientProgressBar_SnapshotTests
//
//  Created by Felix Mau on 07.11.19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import GradientProgressBar

class CustomColorSnapshotTestCase: XCTestCase {
    // MARK: - Config

    /// The frame we use for rendering the `GradientProgressBar`. This will also be the image size for our snapshot.
    private static let frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 4.0)

    /// The trait collection we use for our snapshot.
    private static let traitCollection = UITraitCollection(userInterfaceStyle: .light)

    /// The custom colors we use on this test-case.
    /// Source: https://color.adobe.com/Pink-Flamingo-color-theme-10343714/
    private static let gradientColors = [
        #colorLiteral(red: 0.9490196078, green: 0.3215686275, blue: 0.431372549, alpha: 1), #colorLiteral(red: 0.9450980392, green: 0.4784313725, blue: 0.5921568627, alpha: 1), #colorLiteral(red: 0.9529411765, green: 0.737254902, blue: 0.7843137255, alpha: 1), #colorLiteral(red: 0.4274509804, green: 0.8666666667, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.9411764706, blue: 0.9568627451, alpha: 1),
    ]

    // MARK: - Test cases

    func testGradientProgressBarWithProgressSetToZero() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Self.frame)
        gradientProgressBar.gradientColors = Self.gradientColors

        // When
        gradientProgressBar.progress = 0.0

        // Then
        assertSnapshot(matching: gradientProgressBar, as: .image(traits: Self.traitCollection))
    }

    func testGradientProgressBarWithProgressSetTo33Percent() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Self.frame)
        gradientProgressBar.gradientColors = Self.gradientColors

        // When
        gradientProgressBar.progress = 0.33

        // Then
        assertSnapshot(matching: gradientProgressBar, as: .image(traits: Self.traitCollection))
    }

    func testGradientProgressBarWithProgressSetTo66Percent() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Self.frame)
        gradientProgressBar.gradientColors = Self.gradientColors

        // When
        gradientProgressBar.progress = 0.66

        // Then
        assertSnapshot(matching: gradientProgressBar, as: .image(traits: Self.traitCollection))
    }

    func testGradientProgressBarWithProgressSetTo100Percent() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Self.frame)
        gradientProgressBar.gradientColors = Self.gradientColors

        // When
        gradientProgressBar.progress = 1.0

        // Then
        assertSnapshot(matching: gradientProgressBar, as: .image(traits: Self.traitCollection))
    }
}
