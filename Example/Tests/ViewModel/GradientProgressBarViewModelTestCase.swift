//
//  GradientProgressBarViewModelTestCase.swift
//  GradientProgressBar_Example
//
//  Created by Felix Mau on 20.01.18.
//  Copyright © 2018 CocoaPods. All rights reserved.
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

    // MARK: - Test setup

    func testGradientLayerFrameShouldBeZeroPerDefault() {
        XCTAssertEqual(viewModel.gradientLayerFrame.value, .zero)
    }

    func testAlphaLayerFrameShouldBeZeroPerDefault() {
        XCTAssertEqual(viewModel.alphaLayerFrame.value, .zero)
    }

    func testGradientColorListShouldBeInitializedWithDefaultValue() {
        XCTAssertEqual(viewModel.gradientColorList.value, UIColor.defaultGradientColorList)
    }

    // MARK: - Test setting property `bounds`

    func testSettingBoundsShouldUpdateGradientLayerFrame() {
        // Given
        let bounds = CGRect(x: 2.0, y: 4.0, width: 6.0, height: 8.0)

        // When
        viewModel.bounds = bounds

        // Then
        XCTAssertEqual(viewModel.gradientLayerFrame.value, bounds)
    }

    func testSettingBoundsShouldUpdateAlphaLayerFrameForCurrentProgressWithoutAnimation() {
        // Given
        let progress: Float = 0.5
        viewModel.progress = progress

        // When
        let bounds = CGRect(x: 2.0, y: 4.0, width: 6.0, height: 8.0)
        viewModel.bounds = bounds

        // Then
        var expectedBounds = bounds
        expectedBounds.size.width *= CGFloat(progress)

        let expectedAlphaLayerFrameUpdate = AnimatedFrameUpdate(frame: expectedBounds,
                                                                animationDuration: 0.0)

        XCTAssertEqual(viewModel.alphaLayerFrame.value, expectedAlphaLayerFrameUpdate)
    }

    // MARK: - Test setting property `progress`

    func testSettingProgressShouldUpdateAlphaLayerFrameWithoutAnimation() {
        // Given
        let bounds = CGRect(x: 2.0, y: 4.0, width: 6.0, height: 8.0)
        viewModel.bounds = bounds

        // When
        let progress: Float = 0.25
        viewModel.progress = progress

        // Then
        var expectedBounds = bounds
        expectedBounds.size.width *= CGFloat(progress)

        let expectedAlphaLayerFrameUpdate = AnimatedFrameUpdate(frame: expectedBounds,
                                                                animationDuration: 0.0)

        XCTAssertEqual(viewModel.alphaLayerFrame.value, expectedAlphaLayerFrameUpdate)
    }

    // MARK: - Test method `setGradientColorList()`

    func testSetGradientColorListShouldUpdateObservable() {
        // Given
        let gradientColorList: [UIColor] = [.black, .white]

        // When
        viewModel.setGradientColorList(gradientColorList)

        // Then
        XCTAssertEqual(viewModel.gradientColorList.value, gradientColorList)
    }

    // MARK: - Test method `getGradientColorList()`

    func testGetGradientColorListShouldReturnColorsFromObservables() {
        // Given
        let gradientColorList: [UIColor] = [.black, .white]
        viewModel.setGradientColorList(gradientColorList)

        // When
        let receivedGradientColorList = viewModel.getGradientColorList()

        // Then
        XCTAssertEqual(viewModel.gradientColorList.value, receivedGradientColorList)
    }

    // MARK: - Test method `setProgress()`

    func testSetProgressShouldUpdateAlphaLayerFrameWithoutAnimation() {
        // Given
        let bounds = CGRect(x: 2.0, y: 4.0, width: 6.0, height: 8.0)
        viewModel.bounds = bounds

        // When
        let progress: Float = 0.75
        viewModel.setProgress(progress, animated: false)

        // Then
        var expectedBounds = bounds
        expectedBounds.size.width *= CGFloat(progress)

        let expectedAlphaLayerFrameUpdate = AnimatedFrameUpdate(frame: expectedBounds,
                                                                animationDuration: 0.0)

        XCTAssertEqual(viewModel.alphaLayerFrame.value, expectedAlphaLayerFrameUpdate)
    }

    func testSetProgressAnimatedShouldUpdateAlphaLayerFrameAndUpdateAnimationDuration() {
        // Given
        let bounds = CGRect(x: 2.0, y: 4.0, width: 6.0, height: 8.0)
        viewModel.bounds = bounds

        let animationDuration = 123.456
        viewModel.animationDuration = animationDuration

        // When
        let progress: Float = 0.75
        viewModel.setProgress(progress, animated: true)

        // Then
        var expectedBounds = bounds
        expectedBounds.size.width *= CGFloat(progress)

        let expectedAlphaLayerFrameUpdate = AnimatedFrameUpdate(frame: expectedBounds,
                                                                animationDuration: animationDuration)

        XCTAssertEqual(viewModel.alphaLayerFrame.value, expectedAlphaLayerFrameUpdate)
    }

    func testSettingBoundsAfterAnimatedProgressUpdateShouldUpdateFrameAccordinglyWithoutAnimation() {
        // Given
        let animationDuration = 123.456
        viewModel.animationDuration = animationDuration

        let progress: Float = 0.75
        viewModel.setProgress(progress, animated: true)

        // When
        let bounds = CGRect(x: 2.0, y: 4.0, width: 6.0, height: 8.0)
        viewModel.bounds = bounds

        // Then
        var expectedBounds = bounds
        expectedBounds.size.width *= CGFloat(progress)

        let expectedAlphaLayerFrameUpdate = AnimatedFrameUpdate(frame: expectedBounds,
                                                                animationDuration: 0.0)

        XCTAssertEqual(viewModel.alphaLayerFrame.value, expectedAlphaLayerFrameUpdate)
    }
}
