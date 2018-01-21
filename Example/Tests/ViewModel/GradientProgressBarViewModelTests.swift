//
//  GradientProgressBarViewModelTests.swift
//  GradientProgressBar_Example
//
//  Created by Felix Mau on 20.01.18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import GradientProgressBar

// MARK: - Test case

class GradientProgressBarViewModelTests: XCTestCase {

    /// Accuracy used for floating value comparison.
    let accuracy = CGFloat(Float.ulpOfOne)

    var viewModel: GradientProgressBarViewModel!
    var delegateMock: GradientProgressBarViewModelDelegateMock!

    override func setUp() {
        super.setUp()

        delegateMock = GradientProgressBarViewModelDelegateMock()

        viewModel = GradientProgressBarViewModel()
        viewModel.delegate = delegateMock
    }

    override func tearDown() {
        delegateMock = nil
        viewModel = nil

        super.tearDown()
    }

    // MARK: - Test properties

    func testSetBoundsShouldInformDelegate() {
        let animationDuration = 1.23
        viewModel.animationDuration = animationDuration

        let timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        viewModel.timingFunction = timingFunction

        let bounds = CGRect(x: 0.0, y: 0.0, width: 71.0, height: 3.0)
        viewModel.bounds = bounds

        // Validate updated `gradientLayer`
        let gradientLayerFrame = delegateMock.gradientLayerFrame
        XCTAssertNotNil(gradientLayerFrame, "Expected to have a valid `gradientLayerFrame` from delegate at this point")
        XCTAssertEqual(gradientLayerFrame, bounds)

        // Validate updated `alphaLayer`
        let alphaLayerFrame = delegateMock.alphaLayerFrame
        XCTAssertNotNil(alphaLayerFrame, "Expected to have a valid `alphaLayerFrame` from delegate at this point")

        // `progress` is initialized with "0.0", therefore width should also be "0.0"
        let expectedWidth: CGFloat = 0.0
        XCTAssertEqual(alphaLayerFrame!.width, expectedWidth)
        XCTAssertEqual(alphaLayerFrame!.height, bounds.height)

        let delegateAnimationDuration = delegateMock.animationDuration
        XCTAssertNil(delegateAnimationDuration, "Changes to `bound` should be applied immediatly")

        let delegateTimingFunction = delegateMock.timingFunction
        XCTAssertNil(delegateTimingFunction, "Changes to `bound` should be applied immediatly")
    }

    func testSetProgressShouldInformDelegate() {
        let animationDuration = 4.56
        viewModel.animationDuration = animationDuration

        let timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        viewModel.timingFunction = timingFunction

        let bounds = CGRect(x: 0.0, y: 0.0, width: 89.0, height: 5.0)
        viewModel.bounds = bounds

        let progress: Float = 0.47
        viewModel.progress = progress

        // Validate updated `gradientLayer`
        let gradientLayerFrame = delegateMock.gradientLayerFrame
        XCTAssertNotNil(gradientLayerFrame, "Expected to have a valid `gradientLayerFrame` from delegate at this point")
        XCTAssertEqual(gradientLayerFrame, bounds)

        // Validate updated `alphaLayer`
        let alphaLayerFrame = delegateMock.alphaLayerFrame
        XCTAssertNotNil(alphaLayerFrame, "Expected to have a valid `alphaLayerFrame` from delegate at this point")

        // Width should match current progress value
        let expectedWidth = bounds.width * CGFloat(progress)
        XCTAssertEqual(alphaLayerFrame!.width, expectedWidth, accuracy: accuracy)
        XCTAssertEqual(alphaLayerFrame!.height, bounds.height)

        let delegateAnimationDuration = delegateMock.animationDuration
        XCTAssertNil(delegateAnimationDuration, "Changes to `progress` should be applied immediatly")

        let delegateTimingFunction = delegateMock.timingFunction
        XCTAssertNil(delegateTimingFunction, "Changes to `progress` should be applied immediatly")
    }

    func testSetGradientColorListShouldInformDelegate() {
        let gradientColorList = [UIColor.red, UIColor.yellow, UIColor.green]
        viewModel.gradientColorList = gradientColorList

        let delegateGradientLayerColorList = delegateMock.gradientLayerColorList
        XCTAssertNotNil(delegateGradientLayerColorList, "Expected to have a valid `gradientLayerColorList` from delegate at this point")
        XCTAssertEqual(delegateGradientLayerColorList!, gradientColorList)
    }

    // MARK: - Test methods

    func testSetupForBoundsShouldInformDelegate() {
        let animationDuration = 7.89
        viewModel.animationDuration = animationDuration

        let timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        viewModel.timingFunction = timingFunction

        let bounds = CGRect(x: 0.0, y: 0.0, width: 97.0, height: 3.0)
        viewModel.setup(forBounds: bounds)

        // Validate updated `gradientLayer`
        let gradientLayerFrame = delegateMock.gradientLayerFrame
        XCTAssertNotNil(gradientLayerFrame, "Expected to have a valid `gradientLayerFrame` from delegate at this point")
        XCTAssertEqual(gradientLayerFrame, bounds)

        // Validate updated `alphaLayer`
        let alphaLayerFrame = delegateMock.alphaLayerFrame
        XCTAssertNotNil(alphaLayerFrame, "Expected to have a valid `alphaLayerFrame` from delegate at this point")

        // `progress` is initialized with "0.0", therefore width should also be "0.0"
        let expectedWidth: CGFloat = 0.0
        XCTAssertEqual(alphaLayerFrame!.width, expectedWidth)
        XCTAssertEqual(alphaLayerFrame!.height, bounds.height)

        let delegateAnimationDuration = delegateMock.animationDuration
        XCTAssertNil(delegateAnimationDuration, "Changes to `bound` should be applied immediatly")

        let delegateTimingFunction = delegateMock.timingFunction
        XCTAssertNil(delegateTimingFunction, "Changes to `bound` should be applied immediatly")
    }

    func testSetProgressWithoutAnimationShouldInformDelegate() {
        let animationDuration = 1.23
        viewModel.animationDuration = animationDuration

        let timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        viewModel.timingFunction = timingFunction

        let bounds = CGRect(x: 0.0, y: 0.0, width: 67.0, height: 5.0)
        viewModel.bounds = bounds

        let progress: Float = 0.8
        viewModel.setProgress(progress, animated: false)

        // Validate updated `alphaLayer`
        let alphaLayerFrame = delegateMock.alphaLayerFrame
        XCTAssertNotNil(alphaLayerFrame, "Expected to have a valid `alphaLayerFrame` from delegate at this point")

        // Width should match current progress value
        let expectedWidth = bounds.width * CGFloat(progress)
        XCTAssertEqual(alphaLayerFrame!.width, expectedWidth, accuracy: accuracy)
        XCTAssertEqual(alphaLayerFrame!.height, bounds.height)

        let delegateAnimationDuration = delegateMock.animationDuration
        XCTAssertNil(delegateAnimationDuration, "`animated` is false, therefore changes should be applied immediatly")

        let delegateTimingFunction = delegateMock.timingFunction
        XCTAssertNil(delegateTimingFunction, "`animated` is false, therefore changes should be applied immediatly")
    }

    func testSetProgressWithAnimationShouldInformDelegate() {
        let animationDuration = 4.56
        viewModel.animationDuration = animationDuration

        let timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        viewModel.timingFunction = timingFunction

        let bounds = CGRect(x: 0.0, y: 0.0, width: 59.0, height: 3.0)
        viewModel.bounds = bounds

        let progress: Float = 0.8
        viewModel.setProgress(progress, animated: true)

        // Validate updated `alphaLayer`
        let alphaLayerFrame = delegateMock.alphaLayerFrame
        XCTAssertNotNil(alphaLayerFrame, "Expected to have a valid `alphaLayerFrame` from delegate at this point")

        // Width should match current progress value
        let expectedWidth = bounds.width * CGFloat(progress)
        XCTAssertEqual(alphaLayerFrame!.width, expectedWidth, accuracy: accuracy)
        XCTAssertEqual(alphaLayerFrame!.height, bounds.height)

        let delegateAnimationDuration = delegateMock.animationDuration
        XCTAssertNotNil(delegateAnimationDuration, "Expected to have a valid `animationDuration` from delegate at this point")
        XCTAssertEqual(delegateAnimationDuration!, animationDuration, "`animated` is true, therefore changes should be applied with given animation duration")

        let delegateTimingFunction = delegateMock.timingFunction
        XCTAssertNotNil(delegateTimingFunction, "Expected to have a valid `timingFunction` from delegate at this point")
        XCTAssertEqual(delegateTimingFunction!, timingFunction, "`timingFunction` should be the same as previously applied to view model")
    }
}

// MARK: - Helper: Validate delegate calls

class GradientProgressBarViewModelDelegateMock: GradientProgressBarViewModelDelegate {
    var alphaLayerFrame: CGRect?
    var animationDuration: TimeInterval?
    var timingFunction: CAMediaTimingFunction?

    var gradientLayerFrame: CGRect?
    var gradientLayerColorList: [UIColor]?

    func viewModel(_: GradientProgressBarViewModel, didUpdateAlphaLayerFrame frame: CGRect,
                   animationDuration: TimeInterval?, timingFunction: CAMediaTimingFunction?) {
        alphaLayerFrame = frame

        self.animationDuration = animationDuration
        self.timingFunction = timingFunction
    }

    func viewModel(_: GradientProgressBarViewModel, didUpdateGradientLayerFrame frame: CGRect) {
        gradientLayerFrame = frame
    }

    func viewModel(_: GradientProgressBarViewModel, didUpdateGradientLayerColorList colorList: [UIColor]) {
        gradientLayerColorList = colorList
    }
}
