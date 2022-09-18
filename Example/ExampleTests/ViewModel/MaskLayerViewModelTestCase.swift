//
//  MaskLayerViewModelTestCase.swift
//  ExampleTests
//
//  Created by Felix Mau on 28.08.19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import Combine
import XCTest

@testable import GradientProgressBar

final class MaskLayerViewModelTestCase: XCTestCase {

    // MARK: - Types

    typealias FrameAnimation = MaskLayerViewModel.FrameAnimation

    // MARK: - Private properties

    private var viewModel: MaskLayerViewModel!
    private var subscriptions: Set<AnyCancellable>!

    // MARK: - Public methods

    override func setUp() {
        super.setUp()

        viewModel = MaskLayerViewModel()
        subscriptions = Set()
    }

    override func tearDown() {
        subscriptions = nil
        viewModel = nil

        super.tearDown()
    }

    // MARK: - Test initializer

    func test_initializer_shouldSetMaskLayerFrameAnimation_toZero() {
        // Given
        var receivedMaskLayerFrameAnimation: MaskLayerViewModel.FrameAnimation?
        viewModel.maskLayerFrameAnimation.sink { maskLayerFrameAnimation in
            receivedMaskLayerFrameAnimation = maskLayerFrameAnimation
        }.store(in: &subscriptions)

        // Then
        XCTAssertEqual(receivedMaskLayerFrameAnimation, .zero)
    }

    func test_initializer_shouldSetAnimationDuration_toConfigurationProperty() {
        // Then
        XCTAssertEqual(viewModel.animationDuration, TimeInterval.GradientProgressBar.progressAnimationDuration)
    }

    func test_initializer_shouldSetTimingFunction_toConfigurationProperty() {
        // Then
        XCTAssertEqual(viewModel.timingFunction, CAMediaTimingFunction.GradientProgressBar.progressAnimationFunction)
    }

    // MARK: - Test setting property `bounds`

    func test_setBounds_shouldUpdateMaskLayerFrameAnimation_withCorrectFrame_andTimingFunction_butWithoutDuration() {
        // Given
        let timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        viewModel.timingFunction = timingFunction

        let progress: Float = 0.25
        viewModel.setProgress(progress)

        var receivedMaskLayerFrameAnimation: MaskLayerViewModel.FrameAnimation?
        viewModel.maskLayerFrameAnimation.sink { maskLayerFrameAnimation in
            receivedMaskLayerFrameAnimation = maskLayerFrameAnimation
        }.store(in: &subscriptions)

        // When
        let bounds = CGRect(x: 2, y: 4, width: 6, height: 8)
        viewModel.bounds = bounds

        // Then
        let expectedFrame = bounds.adaptWidth(to: progress)
        let expectedMaskLayerFrameAnimation = FrameAnimation(frame: expectedFrame,
                                                             duration: 0,
                                                             timingFunction: timingFunction)

        XCTAssertEqual(receivedMaskLayerFrameAnimation, expectedMaskLayerFrameAnimation)
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

        var receivedMaskLayerFrameAnimation: MaskLayerViewModel.FrameAnimation?
        viewModel.maskLayerFrameAnimation.sink { maskLayerFrameAnimation in
            receivedMaskLayerFrameAnimation = maskLayerFrameAnimation
        }.store(in: &subscriptions)

        // When
        let progress: Float = 0.75
        viewModel.progress = progress

        // Then
        let expectedFrame = bounds.adaptWidth(to: progress)
        let expectedMaskLayerFrameAnimation = FrameAnimation(frame: expectedFrame,
                                                             duration: 0,
                                                             timingFunction: timingFunction)

        XCTAssertEqual(receivedMaskLayerFrameAnimation, expectedMaskLayerFrameAnimation)
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

        var receivedMaskLayerFrameAnimation: MaskLayerViewModel.FrameAnimation?
        viewModel.maskLayerFrameAnimation.sink { maskLayerFrameAnimation in
            receivedMaskLayerFrameAnimation = maskLayerFrameAnimation
        }.store(in: &subscriptions)

        // When
        let progress: Float = 0.75
        viewModel.setProgress(progress)

        // Then
        let expectedFrame = bounds.adaptWidth(to: progress)
        let expectedMaskLayerFrameAnimation = FrameAnimation(frame: expectedFrame,
                                                             duration: 0,
                                                             timingFunction: timingFunction)

        XCTAssertEqual(receivedMaskLayerFrameAnimation, expectedMaskLayerFrameAnimation)
    }

    func test_setProgressAnimated_shouldUpdateMaskLayerFrameAnimation_withCorrectFrame_andTimingFunction_andDuration() {
        // Given
        let timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        viewModel.timingFunction = timingFunction

        let bounds = CGRect(x: 2, y: 4, width: 6, height: 8)
        viewModel.bounds = bounds

        let animationDuration: TimeInterval = .random(in: 0 ... 100)
        viewModel.animationDuration = animationDuration

        var receivedMaskLayerFrameAnimation: MaskLayerViewModel.FrameAnimation?
        viewModel.maskLayerFrameAnimation.sink { maskLayerFrameAnimation in
            receivedMaskLayerFrameAnimation = maskLayerFrameAnimation
        }.store(in: &subscriptions)

        // When
        let progress: Float = 1
        viewModel.setProgress(progress, animated: true)

        // Then
        let expectedFrame = bounds.adaptWidth(to: progress)
        let expectedMaskLayerFrameAnimation = FrameAnimation(frame: expectedFrame,
                                                             duration: animationDuration,
                                                             timingFunction: timingFunction)

        XCTAssertEqual(receivedMaskLayerFrameAnimation, expectedMaskLayerFrameAnimation)
    }
}

// MARK: - Helper

private extension CGRect {
    func adaptWidth(to percent: Float) -> CGRect {
        var mutableCopy = self
        mutableCopy.size.width *= CGFloat(percent)

        return mutableCopy
    }
}
