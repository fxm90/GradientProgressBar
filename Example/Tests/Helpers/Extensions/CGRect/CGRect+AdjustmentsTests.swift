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
        let width = Double.random(min: 0.0, max: 100.0)
        let height = Double.random(min: 0.0, max: 100.0)

        let rect = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        let increasedRect = rect.update(widthByFactor: 1.1)

        XCTAssertEqual(increasedRect.origin.x, 0.0, accuracy: accuracy)
        XCTAssertEqual(increasedRect.origin.y, 0.0, accuracy: accuracy)

        let expectedWidth = CGFloat(width * 1.1)
        XCTAssertEqual(increasedRect.width, expectedWidth, accuracy: accuracy)

        let expectedHeight = CGFloat(height)
        XCTAssertEqual(increasedRect.height, expectedHeight, accuracy: accuracy)
    }

    func testUpdateWidthByMinus10Percent() {
        let width = Double.random(min: 0.0, max: 100.0)
        let height = Double.random(min: 0.0, max: 100.0)

        let rect = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        let decreasedRect = rect.update(widthByFactor: 0.9)

        XCTAssertEqual(decreasedRect.origin.x, 0.0, accuracy: accuracy)
        XCTAssertEqual(decreasedRect.origin.y, 0.0, accuracy: accuracy)

        let expectedWidth = CGFloat(width * 0.9)
        XCTAssertEqual(decreasedRect.width, expectedWidth, accuracy: accuracy)

        let expectedHeight = CGFloat(height)
        XCTAssertEqual(decreasedRect.height, expectedHeight, accuracy: accuracy)
    }
}

/// Helper class for generating random values
///
/// Notes:
///  - Based on: http://www.seemuapps.com/generating-a-random-number-in-swift
private extension Double {
    static func random(min: Double, max: Double) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
}
