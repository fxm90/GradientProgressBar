//
//  GradientProgressBarSnapshotTestCase.swift
//  ExampleSnapshotTests
//
//  Created by Felix Mau on 07.11.19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import XCTest

@testable import GradientProgressBar

final class GradientProgressBarSnapshotTestCase: XCTestCase {

    // MARK: - Config

    private enum Config {
        /// The frame we use for rendering the `GradientProgressBar`. This will also be the image size for our snapshot.
        static let frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 4.0)

        /// The custom colors we use on this test-case.
        /// Source: https://color.adobe.com/Pink-Flamingo-color-theme-10343714/
        static let gradientColors = [
            #colorLiteral(red: 0.9490196078, green: 0.3215686275, blue: 0.431372549, alpha: 1), #colorLiteral(red: 0.9450980392, green: 0.4784313725, blue: 0.5921568627, alpha: 1), #colorLiteral(red: 0.9529411765, green: 0.737254902, blue: 0.7843137255, alpha: 1), #colorLiteral(red: 0.4274509804, green: 0.8666666667, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.9411764706, blue: 0.9568627451, alpha: 1),
        ]

        /// As the gradient might look slightly different each time, we're using a reduced precision here.
        static let precision = 0.98
    }

    // MARK: - Test `.light` user interface style

    func test_gradientProgressBar_withProgressZero_andLightTraitCollection() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Config.frame)
        gradientProgressBar.overrideUserInterfaceStyle = .light

        // When
        gradientProgressBar.progress = 0.0

        // Then
        assertSnapshot(matching: gradientProgressBar, precision: Config.precision)
    }

    func test_gradientProgressBar_withProgress50Percent_andLightTraitCollection() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Config.frame)
        gradientProgressBar.overrideUserInterfaceStyle = .light

        // When
        gradientProgressBar.progress = 0.5

        // Then
        assertSnapshot(matching: gradientProgressBar, precision: Config.precision)
    }

    func test_gradientProgressBar_withProgress100Percent_andLightTraitCollection() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Config.frame)
        gradientProgressBar.overrideUserInterfaceStyle = .light

        // When
        gradientProgressBar.progress = 1.0

        // Then
        assertSnapshot(matching: gradientProgressBar, precision: Config.precision)
    }

    // MARK: - Test `.dark` user interface style

    func test_gradientProgressBar_withProgressZero_andDarkTraitCollection() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Config.frame)
        gradientProgressBar.overrideUserInterfaceStyle = .dark

        // When
        gradientProgressBar.progress = 0.0

        // Then
        assertSnapshot(matching: gradientProgressBar, precision: Config.precision)
    }

    func test_gradientProgressBar_withProgress50Percent_andDarkTraitCollection() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Config.frame)
        gradientProgressBar.overrideUserInterfaceStyle = .dark

        // When
        gradientProgressBar.progress = 0.5

        // Then
        assertSnapshot(matching: gradientProgressBar, precision: Config.precision)
    }

    func test_gradientProgressBar_withProgress100Percent_andDarkTraitCollection() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Config.frame)
        gradientProgressBar.overrideUserInterfaceStyle = .dark

        // When
        gradientProgressBar.progress = 1.0

        // Then
        assertSnapshot(matching: gradientProgressBar, precision: Config.precision)
    }

    // MARK: - Test custom colors

    func test_gradientProgressBar_withProgressZero_andCustomColors() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Config.frame)
        gradientProgressBar.gradientColors = Config.gradientColors

        // When
        gradientProgressBar.progress = 0.0

        // Then
        assertSnapshot(matching: gradientProgressBar, precision: Config.precision)
    }

    func test_gradientProgressBar_withProgress50Percent_andCustomColors() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Config.frame)
        gradientProgressBar.gradientColors = Config.gradientColors

        // When
        gradientProgressBar.progress = 0.5

        // Then
        assertSnapshot(matching: gradientProgressBar, precision: Config.precision)
    }

    func test_gradientProgressBar_withProgress100Percent_andCustomColors() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Config.frame)
        gradientProgressBar.gradientColors = Config.gradientColors

        // When
        gradientProgressBar.progress = 1.0

        // Then
        assertSnapshot(matching: gradientProgressBar, precision: Config.precision)
    }
}
