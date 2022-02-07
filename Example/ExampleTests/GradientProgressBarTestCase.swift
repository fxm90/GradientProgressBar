//
//  GradientProgressBarTestCase.swift
//  ExampleTests
//
//  Created by Felix Mau on 30.10.17.
//  Copyright © 2017 Felix Mau. All rights reserved.
//

import XCTest

@testable import GradientProgressBar

final class GradientProgressBarTestCase: XCTestCase {
    func test_viewSetup() {
        // When
        let gradientProgressBar = GradientProgressBar(frame: .zero)

        guard
            let firstSubLayer = gradientProgressBar.layer.sublayers?.first,
            let gradientLayer = firstSubLayer as? CAGradientLayer
        else {
            XCTFail("The gradient layer should be added as first sublayer.")
            return
        }

        // Then
        XCTAssertNotNil(gradientLayer.mask, "The gradient layer should contain a mask layer.")
    }
}
