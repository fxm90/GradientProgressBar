//
//  AdvancedExampleViewController.swift
//  GradientProgressBar_Example
//
//  Created by Felix Mau on 08/25/18.
//  Copyright © 2018 Felix Mau. All rights reserved.
//

import UIKit
import GradientProgressBar

class AdvancedExampleViewController: UIViewController {
    // MARK: - Config

    /// Value that the progress bar is increased by on each tap on button.
    static let increaseValue: Float = 0.1

    // MARK: - Outlets

    @IBOutlet private var gradientProgressBar: GradientProgressBar!

    // MARK: - Public methods

    override func viewDidLoad() {
        super.viewDidLoad()

        gradientProgressBar.animationDuration = 0.5

        // Source: https://color.adobe.com/Pink-Flamingo-color-theme-10343714/
        gradientProgressBar.gradientColors = [
            #colorLiteral(red: 0.9490196078, green: 0.3215686275, blue: 0.431372549, alpha: 1), #colorLiteral(red: 0.9450980392, green: 0.4784313725, blue: 0.5921568627, alpha: 1), #colorLiteral(red: 0.9529411765, green: 0.737254902, blue: 0.7843137255, alpha: 1), #colorLiteral(red: 0.4274509804, green: 0.8666666667, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
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
