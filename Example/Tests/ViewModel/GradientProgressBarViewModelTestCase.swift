//
//  GradientProgressBarViewModelTestCase.swift
//  GradientProgressBar_Tests
//
//  Created by Felix Mau on 01/20/18.
//  Copyright © 2018 Felix Mau. All rights reserved.
//

import XCTest
@testable import GradientProgressBar

class GradientProgressBarViewModelTestCase: XCTestCase {
    // MARK: - Types

    typealias AnimatedFrameUpdate = GradientProgressBarViewModel.AnimatedFrameUpdate

    // MARK: - Test setup

    var viewModel: GradientProgressBarViewModel!

    override func setUp() {
        super.setUp()

        viewModel = GradientProgressBarViewModel()
    }

    override func tearDown() {
        viewModel = nil

        super.tearDown()
    }

    // MARK: - Test initializer

    func testInitializerShouldSetAnimatedAlphaLayerFrameUpdateToZero() {
        XCTAssertEqual(viewModel.animatedAlphaLayerFrameUpdate.value, .zero)
    }

    func testInitializerShouldSetAnimationDurationToStaticConfigurationProperty() {
        XCTAssertEqual(viewModel.animationDuration, GradientProgressBarViewModel.defaultAnimationDuration)
    }

    func testInitializerShouldSetTimingFunctionToStaticConfigurationProperty() {
        XCTAssertEqual(viewModel.timingFunction, GradientProgressBarViewModel.defaultTimingFunction)
    }

    // MARK: - Test setting property `bounds`

    func testSettingBoundsShouldSetAnimatedAlphaLayerFrameUpdateWithCorrectFrameButWithoutAnimation() {
        // Given
        let bounds = CGRect(x: 2.0, y: 4.0, width: 6.0, height: 8.0)

        let progress: Float = 0.25
        viewModel.setProgress(progress, animated: false)

        // When
        viewModel.bounds = bounds

        // Then
        var expectedFrame = bounds
        expectedFrame.size.width *= CGFloat(progress)

        let expectedAnimatedAlphaLayerFrameUpdate = AnimatedFrameUpdate(frame: expectedFrame,
                                                                        animationDuration: 0.0)

        XCTAssertEqual(viewModel.animatedAlphaLayerFrameUpdate.value, expectedAnimatedAlphaLayerFrameUpdate)
    }

    // MARK: - Test method `setProgress()`

    func testSetProgressShouldSetAnimatedAlphaLayerFrameUpdateWithCorrectFrameButWithoutAnimation() {
        // Given
        let bounds = CGRect(x: 2.0, y: 4.0, width: 6.0, height: 8.0)
        viewModel.bounds = bounds

        // When
        let progress: Float = 0.5
        viewModel.setProgress(progress, animated: false)

        // Then
        var expectedFrame = bounds
        expectedFrame.size.width *= CGFloat(progress)

        let expectedAnimatedAlphaLayerFrameUpdate = AnimatedFrameUpdate(frame: expectedFrame,
                                                                        animationDuration: 0.0)

        XCTAssertEqual(viewModel.animatedAlphaLayerFrameUpdate.value, expectedAnimatedAlphaLayerFrameUpdate)
    }

    func testSetProgressShouldSetAnimatedAlphaLayerFrameUpdateWithCorrectFrameAndGivenAnimationDuration() {
        // Given
        let bounds = CGRect(x: 2.0, y: 4.0, width: 6.0, height: 8.0)
        viewModel.bounds = bounds

        let animationDuration = 123.456
        viewModel.animationDuration = animationDuration

        // When
        let progress: Float = 0.75
        viewModel.setProgress(progress, animated: true)

        // Then
        var expectedFrame = bounds
        expectedFrame.size.width *= CGFloat(progress)

        let expectedAnimatedAlphaLayerFrameUpdate = AnimatedFrameUpdate(frame: expectedFrame,
                                                                        animationDuration: animationDuration)

        XCTAssertEqual(viewModel.animatedAlphaLayerFrameUpdate.value, expectedAnimatedAlphaLayerFrameUpdate)
    }
}
