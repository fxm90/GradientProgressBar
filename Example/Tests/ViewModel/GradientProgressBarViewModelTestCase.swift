//
//  GradientProgressBarViewModelTestCase.swift
//  GradientProgressBar_Tests
//
//  Created by Felix Mau on 01/20/18.
//  Copyright © 2018 Felix Mau. All rights reserved.
//

import XCTest

@testable import GradientProgressBar
@testable import LightweightObservable

class GradientProgressBarViewModelTestCase: XCTestCase {
    // MARK: - Types

    typealias FrameAnimation = GradientProgressBarViewModel.FrameAnimation

    // MARK: - Private properties

    private var viewModel: GradientProgressBarViewModel!

    // MARK: - Public methods

    override func setUp() {
        super.setUp()

        viewModel = GradientProgressBarViewModel()
    }

    override func tearDown() {
        viewModel = nil

        super.tearDown()
    }

    // MARK: - Test initializer

    func testInitializerShouldSetGradientLayerColorsToStaticConfigurationProperty() {
        let expectedGradientLayerColors =
            UIColor.GradientProgressBar.gradientColors.map { $0.cgColor }

        XCTAssertEqual(viewModel.gradientLayerColors.value, expectedGradientLayerColors)
    }

    func testInitializerShouldSetMaskLayerFrameAnimationToZero() {
        XCTAssertEqual(viewModel.maskLayerFrameAnimation.value, .zero)
    }

    func testInitializerShouldSetAnimationDurationToStaticConfigurationProperty() {
        XCTAssertEqual(viewModel.animationDuration, TimeInterval.GradientProgressBar.progressAnimationDuration)
    }

    func testInitializerShouldSetTimingFunctionToStaticConfigurationProperty() {
        XCTAssertEqual(viewModel.timingFunction, CAMediaTimingFunction.GradientProgressBar.progressAnimationFunction)
    }

    // MARK: - Test setting property `bounds`

    func testSettingBoundsShouldUpdateMaskLayerFrameAnimationWithCorrectFrameButWithoutDuration() {
        // Given
        let progress: Float = 0.25
        viewModel.setProgress(progress)

        let bounds = CGRect(x: 2.0, y: 4.0, width: 6.0, height: 8.0)

        // When
        viewModel.bounds = bounds

        // Then
        var expectedFrame = bounds
        expectedFrame.size.width *= CGFloat(progress)

        let expectedMaskLayerFrameAnimation = FrameAnimation(frame: expectedFrame,
                                                             duration: 0.0)

        XCTAssertEqual(viewModel.maskLayerFrameAnimation.value, expectedMaskLayerFrameAnimation)
    }

    func testSettingBoundsWithSameValueShouldUpdateMaskLayerFrameAnimationJustOnce() {
        // Given
        let progress: Float = 0.25
        viewModel.setProgress(progress)

        let bounds = CGRect(x: 2.0, y: 4.0, width: 6.0, height: 8.0)

        var observerCounter = 0
        var disposeBag = DisposeBag()
        viewModel.maskLayerFrameAnimation.subscribe { _, oldMaskLayerFrameAnimation in
            guard oldMaskLayerFrameAnimation != nil else {
                // Skip initial call to observer.
                return
            }

            observerCounter += 1
        }.disposed(by: &disposeBag)

        // When
        for _ in 1 ... 10 {
            viewModel.bounds = bounds
        }

        // Then
        XCTAssertEqual(observerCounter, 1)
    }

    // MARK: - Test setting property `progress`

    func testSettingProgressValueGraterThanOneShouldBePinnedToOne() {
        // When
        viewModel.progress = 1.1

        // Then
        XCTAssertEqual(viewModel.progress, 1.0)
    }

    func testSettingProgressValueSmallerThanZeroShouldBePinnedToZero() {
        // When
        viewModel.progress = -0.1

        // Then
        XCTAssertEqual(viewModel.progress, 0.0)
    }

    func testSettingProgressShouldUpdateMaskLayerFrameAnimationWithCorrectFrameButWithoutDuration() {
        // Given
        let progress: Float = 0.5
        viewModel.setProgress(progress)

        let bounds = CGRect(x: 2.0, y: 4.0, width: 6.0, height: 8.0)

        // When
        viewModel.bounds = bounds

        // Then
        var expectedFrame = bounds
        expectedFrame.size.width *= CGFloat(progress)

        let expectedMaskLayerFrameAnimation = FrameAnimation(frame: expectedFrame,
                                                             duration: 0.0)

        XCTAssertEqual(viewModel.maskLayerFrameAnimation.value, expectedMaskLayerFrameAnimation)
    }

    // MARK: - Test setting property `gradientColors`

    func testSettingsGradientColorsShouldUpdateGradientLayerColors() {
        // Given
        let gradientColors: [UIColor] = [.red, .yellow, .green]

        // When
        viewModel.gradientColors = gradientColors

        // Then
        let expectedGradientLayerColors = gradientColors.map { $0.cgColor }
        XCTAssertEqual(viewModel.gradientLayerColors.value, expectedGradientLayerColors)
    }

    // MARK: - Test method `setProgress()`

    func testSetProgressShouldUpdateProgressProperty() {
        // When
        let progress: Float = 0.25
        viewModel.setProgress(progress)

        // Then
        XCTAssertEqual(viewModel.progress, progress)
    }

    func testSetProgressWithValueGraterThanOneShouldBePinnedToOne() {
        // When
        viewModel.setProgress(1.1)

        // Then
        XCTAssertEqual(viewModel.progress, 1.0)
    }

    func testSetProgressWithValueSmallerThanZeroShouldBePinnedToZero() {
        // When
        viewModel.setProgress(-0.1)

        // Then
        XCTAssertEqual(viewModel.progress, 0.0)
    }

    func testSetProgressShouldUpdateMaskLayerFrameAnimationWithCorrectFrameButWithoutDuration() {
        // Given
        let bounds = CGRect(x: 2.0, y: 4.0, width: 6.0, height: 8.0)
        viewModel.bounds = bounds

        // When
        let progress: Float = 0.75
        viewModel.setProgress(progress)

        // Then
        var expectedFrame = bounds
        expectedFrame.size.width *= CGFloat(progress)

        let expectedMaskLayerFrameAnimation = FrameAnimation(frame: expectedFrame,
                                                             duration: 0.0)

        XCTAssertEqual(viewModel.maskLayerFrameAnimation.value, expectedMaskLayerFrameAnimation)
    }

    func testSetProgressShouldUpdateMaskLayerFrameAnimationWithCorrectFrameAndDuration() {
        // Given
        let bounds = CGRect(x: 2.0, y: 4.0, width: 6.0, height: 8.0)
        viewModel.bounds = bounds

        let animationDuration = 123.456
        viewModel.animationDuration = animationDuration

        // When
        let progress: Float = 1.0
        viewModel.setProgress(progress, animated: true)

        // Then
        var expectedFrame = bounds
        expectedFrame.size.width *= CGFloat(progress)

        let expectedMaskLayerFrameAnimation = FrameAnimation(frame: expectedFrame,
                                                             duration: animationDuration)

        XCTAssertEqual(viewModel.maskLayerFrameAnimation.value, expectedMaskLayerFrameAnimation)
    }
}
