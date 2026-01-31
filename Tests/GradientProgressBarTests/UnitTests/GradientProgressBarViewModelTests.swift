//
//  GradientProgressBarViewModelTests.swift
//  GradientProgressBarTests
//
//  Created by Felix Mau on 28.08.19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import Foundation
import Testing
@testable import GradientProgressBar

@MainActor
@Suite
struct GradientProgressBarViewModelTests {

  // MARK: - Private Properties

  private let viewModel = GradientProgressBar.ViewModel()

  // MARK: - Test Property `bounds`

  @Test
  func `WHEN setting bounds THEN maskLayerAnimation is updated with correct frame and timing function and no duration`() {
    // Given
    let timingFunction: TimingFunction = .easeInOut
    viewModel.timingFunction = timingFunction

    let progress: Float = 0.25
    viewModel.setProgress(progress)

    // When
    let bounds = CGRect(x: 2, y: 4, width: 6, height: 8)
    viewModel.bounds = bounds

    // Then
    let expectedFrame = bounds.scaledWidth(by: progress)
    let expectedMaskLayerAnimation = LayerAnimation(
      frame: expectedFrame,
      duration: 0,
      timingFunction: timingFunction,
    )

    #expect(viewModel.maskLayerAnimation == expectedMaskLayerAnimation)
  }

  // MARK: - Test Property `progress`

  @Test
  func `WHEN setting progress with value greater than one THEN progress should be clamped to one`() {
    // When
    viewModel.progress = 1.1

    // Then
    #expect(viewModel.progress == 1)
  }

  @Test
  func `WHEN setting progress with value smaller than zero THEN progress should be clamped to zero`() {
    // When
    viewModel.progress = -0.1

    // Then
    #expect(viewModel.progress == 0)
  }

  @Test
  func `WHEN setting progress THEN maskLayerAnimation is updated with correct frame and timing function and no duration`() {
    // Given
    let timingFunction: TimingFunction = .easeInOut
    viewModel.timingFunction = timingFunction

    let bounds = CGRect(x: 2, y: 4, width: 6, height: 8)
    viewModel.bounds = bounds

    // When
    let progress: Float = 0.75
    viewModel.progress = progress

    // Then
    let expectedFrame = bounds.scaledWidth(by: progress)
    let expectedMaskLayerAnimation = LayerAnimation(
      frame: expectedFrame,
      duration: 0,
      timingFunction: timingFunction,
    )

    #expect(viewModel.maskLayerAnimation == expectedMaskLayerAnimation)
  }

  // MARK: - Test Method `setProgress()`

  @Test
  func `WHEN calling setProgress THEN the new value is reflected on property progress`() {
    // When
    let progress: Float = 0.25
    viewModel.setProgress(progress)

    // Then
    #expect(viewModel.progress == progress)
  }

  @Test
  func `WHEN calling setProgress with value greater than one THEN progress should be clamped to one`() {
    // When
    viewModel.setProgress(1.1)

    // Then
    #expect(viewModel.progress == 1)
  }

  @Test
  func `WHEN calling setProgress with value smaller than zero THEN progress should be clamped to zero`() {
    // When
    viewModel.setProgress(-0.1)

    // Then
    #expect(viewModel.progress == 0)
  }

  @Test
  func `WHEN calling setProgress THEN maskLayerAnimation is updated with correct frame and timing function and no duration`() {
    // Given
    let timingFunction: TimingFunction = .easeInOut
    viewModel.timingFunction = timingFunction

    let bounds = CGRect(x: 2, y: 4, width: 6, height: 8)
    viewModel.bounds = bounds

    // When
    let progress: Float = 0.75
    viewModel.setProgress(progress)

    // Then
    let expectedFrame = bounds.scaledWidth(by: progress)
    let expectedMaskLayerAnimation = LayerAnimation(
      frame: expectedFrame,
      duration: 0,
      timingFunction: timingFunction,
    )

    #expect(viewModel.maskLayerAnimation == expectedMaskLayerAnimation)
  }

  @Test
  func `WHEN calling setProgress animated THEN maskLayerAnimation is updated with correct frame and timing function and duration`() {
    // Given
    let timingFunction: TimingFunction = .easeInOut
    viewModel.timingFunction = timingFunction

    let bounds = CGRect(x: 2, y: 4, width: 6, height: 8)
    viewModel.bounds = bounds

    let animationDuration: TimeInterval = .random(in: 0 ... 100)
    viewModel.animationDuration = animationDuration

    // When
    let progress: Float = 1
    viewModel.setProgress(progress, animated: true)

    // Then
    let expectedFrame = bounds.scaledWidth(by: progress)
    let expectedMaskLayerAnimation = LayerAnimation(
      frame: expectedFrame,
      duration: animationDuration,
      timingFunction: timingFunction,
    )

    #expect(viewModel.maskLayerAnimation == expectedMaskLayerAnimation)
  }
}

// MARK: - Helper

private extension CGRect {
  func scaledWidth(by factor: Float) -> CGRect {
    var mutableCopy = self
    mutableCopy.size.width *= CGFloat(factor)

    return mutableCopy
  }
}
