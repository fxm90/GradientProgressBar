//
//  UIColorMakeDynamicColorTestCase.swift
//  ExampleTests
//
//  Created by Felix Mau on 22.09.19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import XCTest

@testable import GradientProgressBar

final class UIColorMakeDynamicColorTestCase: XCTestCase {
    func test_dynamicColor_shouldReturnLightColor_forUnspecifiedInterfaceStyle() {
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

    func test_dynamicColor_shouldReturnLightColor_forLightInterfaceStyle() {
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

    func test_dynamicColor_shouldReturnDarkColor_forDarkInterfaceStyle() {
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
