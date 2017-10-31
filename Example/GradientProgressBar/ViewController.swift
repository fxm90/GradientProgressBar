//
//  ViewController.swift
//  GradientProgressBar
//
//  Created by fxm90 on 09/30/2017.
//  Copyright (c) 2017 fxm90. All rights reserved.
//

import UIKit
import GradientProgressBar

class ViewController: UIViewController {
    @IBOutlet weak var progressView: GradientProgressBar!

    @IBOutlet weak var slowAnimationButton: UIButton!
    @IBOutlet weak var fastAnimationButton: UIButton!
    @IBOutlet weak var skipAnimationButton: UIButton!
    @IBOutlet weak var setButton: UIButton!

    let buttonTintColor = UIColor.white
    let buttonBackgroundColor = UIColor(hexString: "#4990e2")

    /// Value progress view is increased by on each button touch up inside
    let increaseValue: Float = 0.1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Layout buttons
        [slowAnimationButton, fastAnimationButton, skipAnimationButton, setButton].forEach { (button: UIButton) in
            button.layer.cornerRadius = 4.0
            button.tintColor = buttonTintColor
            button.backgroundColor = buttonBackgroundColor
        }
    }

    // MARK: - Helper

    func increasedProgressValue() -> Float {
        let nextProgress = progressView.progress + increaseValue

        let maxProgress = 1.0 + Float.ulpOfOne
        if nextProgress > maxProgress {
            return 0.0
        }

        return nextProgress
    }

    // MARK: - User interaction

    @IBAction func onSlowAnimationButtonTouchUpInside(_ sender: Any) {
        let backupAnimationDuration = progressView.animationDuration

        progressView.animationDuration = 2.0
        progressView.setProgress(increasedProgressValue(), animated: true)

        progressView.animationDuration = backupAnimationDuration
    }

    @IBAction func onFastAnimationButtonTouchUpInside(_ sender: Any) {
        progressView.setProgress(increasedProgressValue(), animated: true)
    }

    @IBAction func onSkipAnimationButtonTouchUpInside(_ sender: Any) {
        progressView.setProgress(increasedProgressValue(), animated: false)
    }

    @IBAction func onSetButtonTouchUpInside(_ sender: Any) {
        progressView.progress = 0.33
    }
}
