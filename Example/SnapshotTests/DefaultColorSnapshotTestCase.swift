//
//  DefaultColorSnapshotTestCase.swift
//  GradientProgressBar_SnapshotTests
//
//  Created by Felix Mau on 07.11.19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import GradientProgressBar

class DefaultColorSnapshotTestCase: XCTestCase {
    // MARK: - Config

    /// The frame we use for rendering the `GradientProgressBar`. This will also be the image size for our snapshot.
    private static let frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 4.0)

    /// The trait collection we use for our snapshot.
    private static let traitCollection = UITraitCollection(userInterfaceStyle: .dark)

    // MARK: - Test cases

    func testGradientProgressBarWithProgressSetToZero() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Self.frame)

        // When
        gradientProgressBar.progress = 0.0

        // Then
        assertSnapshot(matching: gradientProgressBar, as: .image(traits: Self.traitCollection))
    }

    func testGradientProgressBarWithProgressSetTo33Percent() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Self.frame)

        // When
        gradientProgressBar.progress = 0.33

        // Then
        assertSnapshot(matching: gradientProgressBar, as: .image(traits: Self.traitCollection))
    }

    func testGradientProgressBarWithProgressSetTo66Percent() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Self.frame)

        // When
        gradientProgressBar.progress = 0.66

        // Then
        assertSnapshot(matching: gradientProgressBar, as: .image(traits: Self.traitCollection))
    }

    func testGradientProgressBarWithProgressSetTo100Percent() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Self.frame)

        // When
        gradientProgressBar.progress = 1.0

        // Then
        assertSnapshot(matching: gradientProgressBar, as: .image(traits: Self.traitCollection))
    }
}
