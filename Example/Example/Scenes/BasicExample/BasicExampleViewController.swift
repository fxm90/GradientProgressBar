//
//  BasicExampleViewController.swift
//  Example
//
//  Created by Felix Mau on 02.02.22.
//  Copyright © 2022 Felix Mau. All rights reserved.
//

import UIKit
import SwiftUI
import GradientProgressBar

final class BasicExampleViewController: UIViewController {
    // MARK: - Config

    private enum Config {
        /// Value that the progress bar is increased by on each tap on button.
        static let increaseValue: Float = 0.1
    }

    // MARK: - Outlets

    @IBOutlet private var gradientProgressBar: GradientProgressBar!

    // MARK: - Public methods

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

struct BasicExampleView: View {
    var body: some View {
        StoryboardView(name: "BasicExample")
            .navigationTitle("🏡 Basic Example")
    }
}
