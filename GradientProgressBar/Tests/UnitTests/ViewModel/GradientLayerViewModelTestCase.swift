//
//  GradientLayerViewModelTestCase.swift
//  ExampleTests
//
//  Created by Felix Mau on 28.08.19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import Combine
import XCTest

@testable import GradientProgressBar

final class GradientLayerViewModelTestCase: XCTestCase {

    // MARK: - Private properties

    private var viewModel: GradientLayerViewModel!
    private var subscriptions: Set<AnyCancellable>!

    // MARK: - Public methods

    override func setUp() {
        super.setUp()

        viewModel = GradientLayerViewModel()
        subscriptions = Set()
    }

    override func tearDown() {
        subscriptions = nil
        viewModel = nil

        super.tearDown()
    }

    // MARK: - Test initializer

    func test_initializer_shouldSetGradientLayerColors_toConfigurationProperty_mappedToCgColor() {
        // Given
        var receivedGradientLayerColors: [CGColor]?
        viewModel.gradientLayerColors.sink { gradientLayerColors in
            receivedGradientLayerColors = gradientLayerColors
        }.store(in: &subscriptions)

        // Then
        XCTAssertEqual(receivedGradientLayerColors, UIColor.GradientProgressBar.gradientColors.cgColor)
    }

    func test_initializer_shouldSetGradientColors_toConfigurationProperty() {
        // Then
        XCTAssertEqual(viewModel.gradientColors, UIColor.GradientProgressBar.gradientColors)
    }

    // MARK: - Test setting property `gradientColors`

    func test_setGradientColors_shouldUpdateGradientLayerColors() {
        // Given
        var receivedGradientLayerColors: [CGColor]?
        viewModel.gradientLayerColors.sink { gradientLayerColors in
            receivedGradientLayerColors = gradientLayerColors
        }.store(in: &subscriptions)

        // When
        let gradientColors: [UIColor] = [.red, .yellow, .green]
        viewModel.gradientColors = gradientColors

        // Then
        XCTAssertEqual(receivedGradientLayerColors, gradientColors.cgColor)
    }
}

// MARK: - Helper

private extension Array where Element: UIColor {
    /// The Quartz color that corresponds to the color objects.
    var cgColor: [CGColor] {
        map(\.cgColor)
    }
}
