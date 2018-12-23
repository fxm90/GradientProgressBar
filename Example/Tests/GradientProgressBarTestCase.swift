//
//  GradientProgressBarTestCase.swift
//  GradientProgressBar_Tests
//
//  Created by Felix Mau on 10/30/17.
//  Copyright © 2017 Felix Mau. All rights reserved.
//

import XCTest
@testable import GradientProgressBar

class GradientProgressBarTestCase: XCTestCase {
    func testInitialization() {
        let gradientProgressBar = GradientProgressBar(frame: .zero)

        guard
            let firstSubLayer = gradientProgressBar.layer.sublayers?.first,
            let gradientLayer = firstSubLayer as? CAGradientLayer
        else {
            XCTFail("The gradient layer should be added as first sublayer.")
            return
        }

        XCTAssertNotNil(gradientLayer.mask, "The gradient layer should contain a mask layer.")
    }
}
