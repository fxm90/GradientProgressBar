//
//  GradientProgressBarTests.swift
//  GradientProgressBar_Example
//
//  Created by Felix Mau on 30.10.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import GradientProgressBar

class GradientProgressBarTests: XCTestCase {

    func testInitialization() {
        let gradientProgressBar = GradientProgressBar(frame: .zero)

        let firstSublayer = gradientProgressBar.layer.sublayers?.first as? CAGradientLayer

        XCTAssertNotNil(firstSublayer, "`gradientlayer` should be added as first sublayer.")
        XCTAssertNotNil(firstSublayer!.mask, "`gradientlayer` should contain `alphaMaskLayer`.")
    }

    // MARK: - Test computed properties

    func testSetGradientColorList() {
        let gradientColorList = [
            UIColor.red,
            UIColor.yellow,
            UIColor.green
        ]

        let gradientProgressBar = GradientProgressBar(frame: .zero)
        gradientProgressBar.gradientColorList = gradientColorList

        XCTAssertNotNil(gradientProgressBar.gradientColorList, "Expected to have a valid `gradientColorList` at this point")
        XCTAssertEqual(gradientProgressBar.gradientColorList!, gradientColorList)
    }

    func testSetAnimationDuration() {
        let animationDuration = 123.456

        let gradientProgressBar = GradientProgressBar(frame: .zero)
        gradientProgressBar.animationDuration = animationDuration

        XCTAssertNotNil(gradientProgressBar.animationDuration, "Expected to have a valid `animationDuration` at this point")
        XCTAssertEqual(gradientProgressBar.animationDuration!, animationDuration)
    }

    func testSetTimingFunction() {
        let timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)

        let gradientProgressBar = GradientProgressBar(frame: .zero)
        gradientProgressBar.timingFunction = timingFunction

        XCTAssertNotNil(gradientProgressBar.timingFunction, "Expected to have a valid `timingFunction` at this point")
        XCTAssertEqual(gradientProgressBar.timingFunction!, timingFunction)
    }
}
