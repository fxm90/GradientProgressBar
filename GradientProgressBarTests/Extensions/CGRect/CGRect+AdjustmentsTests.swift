//
//  CGRect+AdjustmentsTests.swift
//  GradientProgressBarTests
//
//  Created by Felix Mau on 04.03.17.
//  Copyright © 2017 Felix Mau. All rights reserved.
//

import XCTest
@testable import GradientProgressBar

class CGRectAdjustmentsTests: XCTestCase {

    // "Float.ulpOfOne" - The positive difference between 1.0 and the next greater representable number.
    // Source: https://developer.apple.com/documentation/swift/float/2886872-ulpofone
    let accuracy = CGFloat(Float.ulpOfOne)

    func testUpdateWidthBy10Percent() {
        let rect = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 123.4)
        let rectWidthUpdateBy10Percent = rect.updateWidth(byPercentage: 1.1)

        XCTAssertEqualWithAccuracy(rectWidthUpdateBy10Percent.origin.x, 0.0, accuracy: accuracy)
        XCTAssertEqualWithAccuracy(rectWidthUpdateBy10Percent.origin.y, 0.0, accuracy: accuracy)
        XCTAssertEqualWithAccuracy(rectWidthUpdateBy10Percent.width, 110.0, accuracy: accuracy)
        XCTAssertEqualWithAccuracy(rectWidthUpdateBy10Percent.height, 123.4, accuracy: accuracy)
    }

    func testUpdateWidthByMinus10Percent() {
        let rect = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 123.4)
        let rectWidthUpdateBy10Percent = rect.updateWidth(byPercentage: 0.9)

        XCTAssertEqualWithAccuracy(rectWidthUpdateBy10Percent.origin.x, 0.0, accuracy: accuracy)
        XCTAssertEqualWithAccuracy(rectWidthUpdateBy10Percent.origin.y, 0.0, accuracy: accuracy)
        XCTAssertEqualWithAccuracy(rectWidthUpdateBy10Percent.width, 90.0, accuracy: accuracy)
        XCTAssertEqualWithAccuracy(rectWidthUpdateBy10Percent.height, 123.4, accuracy: accuracy)
    }
}
