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

    /// Accuracy used for floating value comparison.
    let accuracy = Double(Float.ulpOfOne)

    func testInitialization() {
        let gradientProgressBar = GradientProgressBar(frame: .zero)

        guard let firstSublayer = gradientProgressBar.layer.sublayers?.first as? CAGradientLayer else {
            XCTFail("No sublayers added during initialization!")
            return
        }

        // Check `gradientLayer`
        XCTAssertEqual(firstSublayer, gradientProgressBar.gradientLayer, "`gradientlayer` should be added as first sublayer.")

        // Check `alphaMaskLayer`
        XCTAssertEqual(firstSublayer.mask, gradientProgressBar.alphaMaskLayer, "`gradientlayer` should have an alpha mask .")
    }

    func testSetProgressViaVariable() {
        // Generate `GradientLoadingBar` with a random width
        let width = Random.double(min: 1.0, max: 100.0)
        let gradientProgressBar = GradientProgressBar(frame: CGRect(x: 0.0,
                                                                    y: 0.0,
                                                                    width: width,
                                                                    height: 1.0))

        // Test five different percentages. Each should set correct alpha mask width.
        for _ in 1...5 {
            let percentage = Random.float(min: 0.0, max: 1.0)
            gradientProgressBar.progress = percentage

            let alphaMaskLayerFrame = gradientProgressBar.alphaMaskLayer.frame
            XCTAssertEqual(Double(alphaMaskLayerFrame.width), width * Double(percentage), accuracy: accuracy)
        }
    }

    func testSetProgressViaMethodCall() {
        // Generate `GradientLoadingBar` with a random width
        let width = Random.double(min: 1.0, max: 100.0)
        let gradientProgressBar = GradientProgressBar(frame: CGRect(x: 0.0,
                                                                    y: 0.0,
                                                                    width: width,
                                                                    height: 1.0))

        // Test five different percentages. Each should set correct alpha mask width.
        for _ in 1...5 {
            let percentage = Random.float(min: 0.0, max: 1.0)
            gradientProgressBar.setProgress(percentage, animated: false)

            let alphaMaskLayerFrame = gradientProgressBar.alphaMaskLayer.frame
            XCTAssertEqual(Double(alphaMaskLayerFrame.width), width * Double(percentage), accuracy: accuracy)
        }
    }

    func testCustomGradientColorList() {
        let gradientColorList = [
            UIColor.red,
            UIColor.yellow,
            UIColor.green
        ]

        let gradientProgressBar = GradientProgressBar(frame: .zero)
        gradientProgressBar.gradientColorList = gradientColorList

        guard let firstSublayer = gradientProgressBar.layer.sublayers?.first as? CAGradientLayer,
              let sublayerColorList = firstSublayer.colors as? [CGColor]
        else {
            XCTFail("Could not get gradient color list")
            return
        }

        // Verify colors of sublayer
        XCTAssertEqual(sublayerColorList, gradientColorList.map({ $0.cgColor }))
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
