//
//  GradientProgressBarViewStyleSnapshotTestCase.swift
//  ExampleSnapshotTests
//
//  Created by Felix Mau on 07.02.22.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import XCTest
import SwiftUI
import SnapshotTesting

@testable import GradientProgressBar

// swiftlint:disable:next type_name
final class GradientProgressBarViewStyleSnapshotTestCase: XCTestCase {
    // MARK: - Config

    private enum Config {
        /// The frame we use for rendering the `GradientProgressBar`. This will also be the image size for our snapshot.
        static let frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 4.0)

        /// The custom colors we use on this test-case.
        /// Source: https://color.adobe.com/Pink-Flamingo-color-theme-10343714/
        static let gradientColors = [
            #colorLiteral(red: 0.9490196078, green: 0.3215686275, blue: 0.431372549, alpha: 1), #colorLiteral(red: 0.9450980392, green: 0.4784313725, blue: 0.5921568627, alpha: 1), #colorLiteral(red: 0.9529411765, green: 0.737254902, blue: 0.7843137255, alpha: 1), #colorLiteral(red: 0.4274509804, green: 0.8666666667, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.9411764706, blue: 0.9568627451, alpha: 1),
        ].map(Color.init)

        static let lightTraitCollection = UITraitCollection(userInterfaceStyle: .light)
        static let darkTraitCollection = UITraitCollection(userInterfaceStyle: .dark)
    }

    // MARK: - Test `.light` user interface style

    func testGradientProgressBarWithProgressZeroAndLightTraitCollection() {
        // When
        let progressView = ProgressView("", value: 0, total: 100)
            .progressViewStyle(.gradientProgressBar)
            .frame(width: Config.frame.width, height: Config.frame.height)

        // Then
        assertSnapshot(matching: progressView, as: .image(traits: Config.lightTraitCollection))
    }

    func testGradientProgressBarWithProgress33PercentAndLightTraitCollection() {
        // When
        let progressView = ProgressView("", value: 33, total: 100)
            .progressViewStyle(.gradientProgressBar)
            .frame(width: Config.frame.width, height: Config.frame.height)

        // Then
        assertSnapshot(matching: progressView, as: .image(traits: Config.lightTraitCollection))
    }

    func testGradientProgressBarWithProgress66PercentAndLightTraitCollection() {
        // When
        let progressView = ProgressView("", value: 66, total: 100)
            .progressViewStyle(.gradientProgressBar)
            .frame(width: Config.frame.width, height: Config.frame.height)

        // Then
        assertSnapshot(matching: progressView, as: .image(traits: Config.lightTraitCollection))
    }

    func testGradientProgressBarWithProgress100PercentAndLightTraitCollection() {
        // When
        let progressView = ProgressView("", value: 100, total: 100)
            .progressViewStyle(.gradientProgressBar)
            .frame(width: Config.frame.width, height: Config.frame.height)

        // Then
        assertSnapshot(matching: progressView, as: .image(traits: Config.lightTraitCollection))
    }

    // MARK: - Test `.dark` user interface style

    func testGradientProgressBarWithProgressZeroAndDarkTraitCollection() {
        // When
        let progressView = ProgressView("", value: 0, total: 100)
            .progressViewStyle(.gradientProgressBar)
            .frame(width: Config.frame.width, height: Config.frame.height)

        // Then
        assertSnapshot(matching: progressView, as: .image(traits: Config.darkTraitCollection))
    }

    func testGradientProgressBarWithProgress33PercentAndDarkTraitCollection() {
        // When
        let progressView = ProgressView("", value: 33, total: 100)
            .progressViewStyle(.gradientProgressBar)
            .frame(width: Config.frame.width, height: Config.frame.height)

        // Then
        assertSnapshot(matching: progressView, as: .image(traits: Config.darkTraitCollection))
    }

    func testGradientProgressBarWithProgress66PercentAndDarkTraitCollection() {
        // When
        let progressView = ProgressView("", value: 66, total: 100)
            .progressViewStyle(.gradientProgressBar)
            .frame(width: Config.frame.width, height: Config.frame.height)

        // Then
        assertSnapshot(matching: progressView, as: .image(traits: Config.darkTraitCollection))
    }

    func testGradientProgressBarWithProgress100PercentAndDarkTraitCollection() {
        // When
        let progressView = ProgressView("", value: 100, total: 100)
            .progressViewStyle(.gradientProgressBar)
            .frame(width: Config.frame.width, height: Config.frame.height)

        // Then
        assertSnapshot(matching: progressView, as: .image(traits: Config.darkTraitCollection))
    }

    // MARK: - Test custom background color

    func testGradientProgressBarWithProgressZeroAndCustomBackgroundColor() {
        // Given
        let backgroundColor: Color = .cyan

        // When
        let progressView = ProgressView("", value: 0, total: 100)
            .progressViewStyle(.gradientProgressBar(backgroundColor: backgroundColor))
            .frame(width: Config.frame.width, height: Config.frame.height)

        // Then
        assertSnapshot(matching: progressView, as: .image(traits: Config.lightTraitCollection))
    }

    // MARK: - Test custom colors

    func testGradientProgressBarWithProgressZeroAndCustomColors() {
        // When
        let progressView = ProgressView("", value: 100, total: 100)
            .progressViewStyle(.gradientProgressBar(gradientColors: Config.gradientColors))
            .frame(width: Config.frame.width, height: Config.frame.height)

        // Then
        assertSnapshot(matching: progressView, as: .image(traits: Config.lightTraitCollection))
    }

    func testGradientProgressBarWithProgress33PercentAndCustomColors() {
        // When
        let progressView = ProgressView("", value: 33, total: 100)
            .progressViewStyle(.gradientProgressBar(gradientColors: Config.gradientColors))
            .frame(width: Config.frame.width, height: Config.frame.height)

        // Then
        assertSnapshot(matching: progressView, as: .image(traits: Config.lightTraitCollection))
    }

    func testGradientProgressBarWithProgress66PercentAndCustomColors() {
        // When
        let progressView = ProgressView("", value: 66, total: 100)
            .progressViewStyle(.gradientProgressBar(gradientColors: Config.gradientColors))
            .frame(width: Config.frame.width, height: Config.frame.height)

        // Then
        assertSnapshot(matching: progressView, as: .image(traits: Config.lightTraitCollection))
    }

    func testGradientProgressBarWithProgress100PercentAndCustomColors() {
        // When
        let progressView = ProgressView("", value: 100, total: 100)
            .progressViewStyle(.gradientProgressBar(gradientColors: Config.gradientColors))
            .frame(width: Config.frame.width, height: Config.frame.height)

        // Then
        assertSnapshot(matching: progressView, as: .image(traits: Config.lightTraitCollection))
    }

    // MARK: - Test custom background color

    func testGradientProgressBarWithProgress50AndCustomCornerRadius() {
        // Given
        let frame = CGRect(x: 0, y: 0, width: Config.frame.width, height: 20)
        let cornerRadius = frame.height / 2

        // When
        let progressView = ProgressView("", value: 50, total: 100)
            .progressViewStyle(.gradientProgressBar(cornerRadius: cornerRadius))
            .frame(width: frame.width, height: frame.height)

        // Then
        assertSnapshot(matching: progressView, as: .image(traits: Config.lightTraitCollection))
    }
}
