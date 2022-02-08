//
//  MaskLayerViewModelTestCase.swift
//  ExampleTests
//
//  Created by Felix Mau on 28.08.19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import XCTest

@testable import GradientProgressBar
@testable import LightweightObservable

final class MaskLayerViewModelTestCase: XCTestCase {
    // MARK: - Types

    typealias FrameAnimation = MaskLayerViewModel.FrameAnimation

    // MARK: - Private properties

    private var viewModel: MaskLayerViewModel!

    // MARK: - Public methods

    override func setUp() {
        super.setUp()

        viewModel = MaskLayerViewModel()
    }

    override func tearDown() {
        viewModel = nil

        super.tearDown()
    }

    // MARK: - Test initializer

    func test_initializer_shouldSetMaskLayerFrameAnimation_toZero() {
        XCTAssertEqual(viewModel.maskLayerFrameAnimation.value, .zero)
    }

    func test_initializer_shouldSetAnimationDuration_toStaticConfigurationProperty() {
        XCTAssertEqual(viewModel.animationDuration, TimeInterval.GradientProgressBar.progressAnimationDuration)
    }

    func test_initializer_shouldSetTimingFunction_toStaticConfigurationProperty() {
        XCTAssertEqual(viewModel.timingFunction, CAMediaTimingFunction.GradientProgressBar.progressAnimationFunction)
    }

    // MARK: - Test setting property `bounds`

    func test_setBounds_shouldUpdateMaskLayerFrameAnimation_withCorrectFrame_andTimingFunction_butWithoutDuration() {
        // Given
        let timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        viewModel.timingFunction = timingFunction

        let progress: Float = 0.25
        viewModel.setProgress(progress)

        let bounds = CGRect(x: 2, y: 4, width: 6, height: 8)

        // When
        viewModel.bounds = bounds

        // Then
        let expectedMaskLayerFrameAnimation = FrameAnimation(frame: bounds.adaptedWidth(percent: progress),
                                                             duration: 0,
                                                             timingFunction: timingFunction)

        XCTAssertEqual(viewModel.maskLayerFrameAnimation.value, expectedMaskLayerFrameAnimation)
    }

    func test_setBounds_withSameValue_shouldUpdateMaskLayerFrameAnimation_justOnce() {
        // Given
        let bounds = CGRect(x: 2, y: 4, width: 6, height: 8)

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

    func test_setPropertyProgress_withValueGreaterThanOne_shouldBeClampedToOne() {
        // When
        viewModel.progress = 1.1

        // Then
        XCTAssertEqual(viewModel.progress, 1)
    }

    func test_setPropertyProgress_withValueSmallerThanZero_shouldBeClampedToZero() {
        // When
        viewModel.progress = -0.1

        // Then
        XCTAssertEqual(viewModel.progress, 0)
    }

    func test_setPropertyProgress_shouldUpdateMaskLayerFrameAnimation_withCorrectFrame_andTimingFunction_butWithoutDuration() {
        // Given
        let timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        viewModel.timingFunction = timingFunction

        let bounds = CGRect(x: 2, y: 4, width: 6, height: 8)
        viewModel.bounds = bounds

        // When
        let progress: Float = 0.75
        viewModel.progress = progress

        // Then
        let expectedMaskLayerFrameAnimation = FrameAnimation(frame: bounds.adaptedWidth(percent: progress),
                                                             duration: 0,
                                                             timingFunction: timingFunction)

        XCTAssertEqual(viewModel.maskLayerFrameAnimation.value, expectedMaskLayerFrameAnimation)
    }

    // MARK: - Test method `setProgress()`

    func test_setProgress_shouldUpdateProgressProperty() {
        // When
        let progress: Float = 0.25
        viewModel.setProgress(progress)

        // Then
        XCTAssertEqual(viewModel.progress, progress)
    }

    func test_setProgress_withValueGraterThanOne_shouldBeClampedToOne() {
        // When
        viewModel.setProgress(1.1)

        // Then
        XCTAssertEqual(viewModel.progress, 1)
    }

    func test_setProgress_withValueSmallerThanZero_shouldBeClampedToZero() {
        // When
        viewModel.setProgress(-0.1)

        // Then
        XCTAssertEqual(viewModel.progress, 0)
    }

    func test_setProgress_shouldUpdateMaskLayerFrameAnimation_withCorrectFrame_andTimingFunction_butWithoutDuration() {
        // Given
        let timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        viewModel.timingFunction = timingFunction

        let bounds = CGRect(x: 2, y: 4, width: 6, height: 8)
        viewModel.bounds = bounds

        // When
        let progress: Float = 0.75
        viewModel.setProgress(progress)

        // Then
        let expectedMaskLayerFrameAnimation = FrameAnimation(frame: bounds.adaptedWidth(percent: progress),
                                                             duration: 0,
                                                             timingFunction: timingFunction)

        XCTAssertEqual(viewModel.maskLayerFrameAnimation.value, expectedMaskLayerFrameAnimation)
    }

    func test_setProgressAnimated_shouldUpdateMaskLayerFrameAnimation_withCorrectFrame_andTimingFunction_andDuration() {
        // Given
        let timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        viewModel.timingFunction = timingFunction

        let animationDuration = 123.456
        viewModel.animationDuration = animationDuration

        let bounds = CGRect(x: 2, y: 4, width: 6, height: 8)
        viewModel.bounds = bounds

        // When
        let progress: Float = 1
        viewModel.setProgress(progress, animated: true)

        // Then
        let expectedMaskLayerFrameAnimation = FrameAnimation(frame: bounds.adaptedWidth(percent: progress),
                                                             duration: animationDuration,
                                                             timingFunction: timingFunction)

        XCTAssertEqual(viewModel.maskLayerFrameAnimation.value, expectedMaskLayerFrameAnimation)
    }
}

// MARK: - Helpers

private extension CGRect {
    func adaptedWidth(percent: Float) -> CGRect {
        var mutableCopy = self
        mutableCopy.size.width *= CGFloat(percent)

        return mutableCopy
    }
}
