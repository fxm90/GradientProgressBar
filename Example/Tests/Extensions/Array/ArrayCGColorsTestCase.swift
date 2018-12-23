//
//  ArrayCGColorsTestCase.swift
//  GradientProgressBar_Tests
//
//  Created by Felix Mau on 12/23/18.
//  Copyright © 2018 Felix Mau. All rights reserved.
//

import XCTest

@testable import GradientProgressBar

class ArrayCGColorsTestCase: XCTestCase {
    func testArrayShouldContainCorrectCGColors() {
        // Given
        let uiColors: [UIColor] = [.red, .yellow, .green]

        // When
        let cgColors = uiColors.cgColors

        // Then
        XCTAssertEqual(uiColors.count, cgColors.count)

        for (index, uiColor) in uiColors.enumerated() {
            let expectedCGColor = uiColor.cgColor
            let receivedCGColor = cgColors[index]

            XCTAssertEqual(expectedCGColor, receivedCGColor)
        }
    }
}
