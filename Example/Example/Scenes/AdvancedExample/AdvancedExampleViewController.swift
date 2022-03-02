//
//  AdvancedExampleViewController.swift
//  Example
//
//  Created by Felix Mau on 02.02.22.
//  Copyright © 2022 Felix Mau. All rights reserved.
//

import UIKit
import SwiftUI
import GradientProgressBar

final class AdvancedExampleViewController: UIViewController {
    // MARK: - Config

    private enum Config {
        /// Value that the progress bar is increased by on each tap on button.
        static let increaseValue: Float = 0.1

        /// The custom animation duration we use.
        static let animationDuration: TimeInterval = 0.5

        /// The custom gradient colors we use (<https://color.adobe.com/Pink-Flamingo-color-theme-10343714/>).
        static let gradientColors = [
            #colorLiteral(red: 0.9490196078, green: 0.3215686275, blue: 0.431372549, alpha: 1), #colorLiteral(red: 0.9450980392, green: 0.4784313725, blue: 0.5921568627, alpha: 1), #colorLiteral(red: 0.9529411765, green: 0.737254902, blue: 0.7843137255, alpha: 1), #colorLiteral(red: 0.4274509804, green: 0.8666666667, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.9411764706, blue: 0.9568627451, alpha: 1),
        ]

        /// The custom timing function we use (ease-in-back).
        static let timingFunction = CAMediaTimingFunction(controlPoints: 0.600, -0.280, 0.735, 0.045)
    }

    // MARK: - Outlets

    @IBOutlet private var gradientProgressBar: GradientProgressBar!

    // MARK: - Public methods

    override func viewDidLoad() {
        super.viewDidLoad()

        gradientProgressBar.animationDuration = Config.animationDuration
        gradientProgressBar.gradientColors = Config.gradientColors
        gradientProgressBar.timingFunction = Config.timingFunction
    }

    // MARK: - Private methods

    @IBAction private func animateButtonTouchUpInside(_: Any) {
        let currentProgress = gradientProgressBar.progress
        let updatedProgress = currentProgress + Config.increaseValue

        gradientProgressBar.setProgress(updatedProgress, animated: true)
    }

    @IBAction private func setProgressButtonTouchUpInside(_: Any) {
        let currentProgress = gradientProgressBar.progress
        let updatedProgress = currentProgress + Config.increaseValue

        gradientProgressBar.progress = updatedProgress
    }

    @IBAction private func resetButtonTouchUpInside(_: Any) {
        gradientProgressBar.progress = 0.0
    }
}

// MARK: - Helpers

struct AdvancedExampleView: View {
    var body: some View {
        StoryboardView(name: "AdvancedExample")
            .navigationTitle("🚀 Advanced Example")
    }
}
