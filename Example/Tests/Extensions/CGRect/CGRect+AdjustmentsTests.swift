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

    /// Accuracy used for floating value comparison.
    let accuracy = CGFloat(Float.ulpOfOne)

    func testUpdateWidthBy10Percent() {
        let width = Random.double(min: 0.0, max: 100.0)
        let height = Random.double(min: 0.0, max: 100.0)

        let rect = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        let rectWidthUpdateBy10Percent = rect.update(widthByFactor: 1.1)

        XCTAssertEqual(rectWidthUpdateBy10Percent.origin.x, 0.0, accuracy: accuracy)
        XCTAssertEqual(rectWidthUpdateBy10Percent.origin.y, 0.0, accuracy: accuracy)

        XCTAssertEqual(rectWidthUpdateBy10Percent.width, CGFloat(width * 1.1), accuracy: accuracy)
        XCTAssertEqual(rectWidthUpdateBy10Percent.height, CGFloat(height), accuracy: accuracy)
    }

    func testUpdateWidthByMinus10Percent() {

        let width = Random.double(min: 0.0, max: 100.0)
        let height = Random.double(min: 0.0, max: 100.0)

        let rect = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        let rectWidthUpdateByMinus10Percent = rect.update(widthByFactor: 0.9)

        XCTAssertEqual(rectWidthUpdateByMinus10Percent.origin.x, 0.0, accuracy: accuracy)
        XCTAssertEqual(rectWidthUpdateByMinus10Percent.origin.y, 0.0, accuracy: accuracy)

        XCTAssertEqual(rectWidthUpdateByMinus10Percent.width, CGFloat(width * 0.9), accuracy: accuracy)
        XCTAssertEqual(rectWidthUpdateByMinus10Percent.height, CGFloat(height), accuracy: accuracy)
    }
}

/// Helper class for generating random values
///
/// Notes:
///  - Based on: http://www.seemuapps.com/generating-a-random-number-in-swift
private class Random {

    static func double(min: Double, max: Double) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }

    static func float(min: Float, max: Float) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
}
