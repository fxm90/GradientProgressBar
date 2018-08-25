//
//  AdvancedExampleViewController.swift
//  GradientProgressBar_Example
//
//  Created by Felix Mau on 25.08.18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import GradientProgressBar

class AdvancedExampleViewController: UIViewController {
    // MARK: - Config

    /// Value that the progress bar is increased by on each tap on button.
    static let increaseValue: Float = 0.1

    // MARK: - Outlets

    @IBOutlet var gradientProgressBar: GradientProgressBar!

    // MARK: - Public methods

    override func viewDidLoad() {
        super.viewDidLoad()

        gradientProgressBar.animationDuration = 0.5

        // Source: https://color.adobe.com/Pink-Flamingo-color-theme-10343714/
        gradientProgressBar.gradientColorList = [
            UIColor(hex: "#f2526e"),
            UIColor(hex: "#f17a97"),
            UIColor(hex: "#f3bcc8"),
            UIColor(hex: "#6dddf2"),
            UIColor(hex: "#c1f0f4")
        ]

        let easeInBack = CAMediaTimingFunction(controlPoints: 0.600, -0.280, 0.735, 0.045)
        gradientProgressBar.timingFunction = easeInBack
    }

    @IBAction func onAnimateButtonTouchUpInside(_: Any) {
        let currentProgress = gradientProgressBar.progress
        let updatedProgress = currentProgress + BasicExampleViewController.increaseValue

        gradientProgressBar.setProgress(updatedProgress, animated: true)
    }

    @IBAction func onSetProgressButtonTouchUpInside(_: Any) {
        let currentProgress = gradientProgressBar.progress
        let updatedProgress = currentProgress + BasicExampleViewController.increaseValue

        gradientProgressBar.progress = updatedProgress
    }

    @IBAction func onResetButtonTouchUpInside(_: Any) {
        gradientProgressBar.progress = 0.0
    }
}
