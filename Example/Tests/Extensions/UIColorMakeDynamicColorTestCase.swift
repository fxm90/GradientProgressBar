//
//  UIColorMakeDynamicColorTestCase.swift
//  GradientProgressBar_Tests
//
//  Created by Felix Mau on 22.09.19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import XCTest
@testable import GradientProgressBar

class UIColorMakeDynamicColorTestCase: XCTestCase {
    func testDynamicColorShouldReturnLightColorInUnspecifiedInterfaceStyle() {
        // Given
        let lightColor: UIColor = .white
        let darkColor: UIColor = .black

        // When
        let dynamicColor: UIColor = .makeDynamicColor(lightVariant: lightColor,
                                                      darkVariant: darkColor)

        // Then
        let traitCollection = UITraitCollection(userInterfaceStyle: .unspecified)
        let resolvedColor = dynamicColor.resolvedColor(with: traitCollection)

        XCTAssertEqual(resolvedColor, lightColor)
    }

    func testDynamicColorShouldReturnLightColorInLightInterfaceStyle() {
        // Given
        let lightColor: UIColor = .white
        let darkColor: UIColor = .black

        // When
        let dynamicColor: UIColor = .makeDynamicColor(lightVariant: lightColor,
                                                      darkVariant: darkColor)

        // Then
        let traitCollection = UITraitCollection(userInterfaceStyle: .light)
        let resolvedColor = dynamicColor.resolvedColor(with: traitCollection)

        XCTAssertEqual(resolvedColor, lightColor)
    }

    func testDynamicColorShouldReturnDarkColorInDarkInterfaceStyle() {
        // Given
        let lightColor: UIColor = .white
        let darkColor: UIColor = .black

        // When
        let dynamicColor: UIColor = .makeDynamicColor(lightVariant: lightColor,
                                                      darkVariant: darkColor)

        // Then
        let traitCollection = UITraitCollection(userInterfaceStyle: .dark)
        let resolvedColor = dynamicColor.resolvedColor(with: traitCollection)

        XCTAssertEqual(resolvedColor, darkColor)
    }
}
