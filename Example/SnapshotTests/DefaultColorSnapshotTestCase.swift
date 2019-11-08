//
//  DefaultColorSnapshotTestCase.swift
//  GradientProgressBar_SnapshotTests
//
//  Created by Felix Mau on 11/07/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import GradientProgressBar

class DefaultColorSnapshotTestCase: XCTestCase {
    // MARK: - Config

    /// The frame we use for rendering the `GradientProgressBar`. This will also be the image size for our snapshot.
    private static let testFrame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 4.0)

    // MARK: - Test cases

    func testGradientProgressBarWithProgressSetToZero() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Self.testFrame)

        // When
        gradientProgressBar.progress = 0.0

        // Then
        assertSnapshot(matching: gradientProgressBar, as: .image)
    }

    func testGradientProgressBarWithProgressSetTo33Percent() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Self.testFrame)

        // When
        gradientProgressBar.progress = 0.33

        // Then
        assertSnapshot(matching: gradientProgressBar, as: .image)
    }

    func testGradientProgressBarWithProgressSetTo66Percent() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Self.testFrame)

        // When
        gradientProgressBar.progress = 0.66

        // Then
        assertSnapshot(matching: gradientProgressBar, as: .image)
    }

    func testGradientProgressBarWithProgressSetTo100Percent() {
        // Given
        let gradientProgressBar = GradientProgressBar(frame: Self.testFrame)

        // When
        gradientProgressBar.progress = 1.0

        // Then
        assertSnapshot(matching: gradientProgressBar, as: .image)
    }
}
