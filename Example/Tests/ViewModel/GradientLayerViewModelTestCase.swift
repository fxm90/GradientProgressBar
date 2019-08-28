//
//  GradientLayerViewModelTestCase.swift
//  GradientProgressBar_Example
//
//  Created by Felix Mau on 08/28/19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import XCTest

@testable import GradientProgressBar
@testable import LightweightObservable

class GradientLayerViewModelTestCase: XCTestCase {
    // MARK: - Private properties

    private var viewModel: GradientLayerViewModel!

    // MARK: - Public methods

    override func setUp() {
        super.setUp()

        viewModel = GradientLayerViewModel()
    }

    override func tearDown() {
        viewModel = nil

        super.tearDown()
    }

    // MARK: - Test initializer

    func testInitializerShouldSetGradientLayerColorsToStaticConfigurationPropertyMappedToCgColor() {
        let expectedGradientLayerColors =
            makeGradientLayerColors(from: UIColor.GradientProgressBar.gradientColors)

        XCTAssertEqual(viewModel.gradientLayerColors.value, expectedGradientLayerColors)
    }

    func testInitializerShouldSetGradientColorsToStaticConfigurationProperty() {
        XCTAssertEqual(viewModel.gradientColors, UIColor.GradientProgressBar.gradientColors)
    }

    // MARK: - Test setting property `gradientColors`

    func testSettingsGradientColorsShouldUpdateGradientLayerColors() {
        // Given
        let gradientColors: [UIColor] = [.red, .yellow, .green]

        // When
        viewModel.gradientColors = gradientColors

        // Then
        let expectedGradientLayerColors = makeGradientLayerColors(from: gradientColors)
        XCTAssertEqual(viewModel.gradientLayerColors.value, expectedGradientLayerColors)
    }
}

// MARK: - Helpers

extension GradientLayerViewModelTestCase {
    private func makeGradientLayerColors(from gradientColors: [UIColor]) -> [CGColor] {
        return gradientColors.map { $0.cgColor }
    }
}
