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

    // MARK: - UIElements

    @IBOutlet weak var progressView: GradientProgressBar!
    @IBOutlet weak var stackView: UIStackView!

    let colorSchemeLabel = UILabel()
    let timingFunctionLabel = UILabel()

    let slowAnimationButton = UIButton()
    let fastAnimationButton = UIButton()
    let skipAnimationButton = UIButton()
    let changeColorButton = UIButton()
    let changeTimingFunctionButton = UIButton()

    let resetButton = UIButton()

    // MARK: - Types

    enum GradientColorSchemeList: Int, InfiniteIteration {
        case `default`
        case pinkFlamingo

        static let first: GradientColorSchemeList = .`default`

        var asColorList: [UIColor]? {
            switch self {
            case .`default`:
                return nil

            case .pinkFlamingo:
                // Source: https://color.adobe.com/Pink-Flamingo-color-theme-10343714/
                return [
                    UIColor(hex:"#f2526e"),
                    UIColor(hex:"#f17a97"),
                    UIColor(hex:"#f3bcc8"),
                    UIColor(hex:"#6dddf2"),
                    UIColor(hex:"#c1f0f4")
                ]
            }
        }
    }

    enum TimingFunctionList: Int, InfiniteIteration {
        case `default`
        case easeInCubic
        case easeInBack

        static let first: TimingFunctionList = .`default`

        var asTimingFunction: CAMediaTimingFunction? {
            switch self {
            case .`default`:
                return nil

            case .easeInCubic:
                return CAMediaTimingFunction(controlPoints: 0.550, 0.055, 0.675, 0.190)

            case .easeInBack:
                return CAMediaTimingFunction(controlPoints: 0.600, -0.280, 0.735, 0.045)
            }
        }
    }

    // MARK: - Properties

    /// Current color scheme
    var gradientColorScheme: GradientColorSchemeList = .`default` {
        didSet {
            updateColorSchemeLabel()
        }
    }

    /// Current timing function
    var timingFunction: TimingFunctionList = .`default` {
        didSet {
            updateTimingFunctionLabel()
        }
    }

    /// Value that progress bar is increased by on each tap on button
    let increaseValue: Float = 0.1

    /// Calculates next value for progress bar
    var nextProgressValue: Float {
        let nextProgressValue = progressView.progress + increaseValue
        return min(nextProgressValue, 1.0)
    }

    // MARK: - Layout

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        setupDebugLabels()
        setupButtons()
    }

    // MARK: - Debug labels

    func setupDebugLabels() {
        updateColorSchemeLabel()
        updateTimingFunctionLabel()

        // Layout labels
        [colorSchemeLabel, timingFunctionLabel].forEach { (label: UILabel) in
            label.font = UIFont.systemFont(ofSize: 13.0, weight: .light)

            stackView.addArrangedSubview(label)
        }

        updateColorSchemeLabel()
        updateTimingFunctionLabel()
    }

    func updateColorSchemeLabel() {
        let formattedString = NSMutableAttributedString()
        formattedString
            .normal("Color Scheme: ", size: 13)
            .bold("\(gradientColorScheme)", size: 13)

        colorSchemeLabel.attributedText = formattedString
    }

    func updateTimingFunctionLabel() {
        let formattedString = NSMutableAttributedString()
        formattedString
            .normal("Timing Function: ", size: 13)
            .bold("\(timingFunction)", size: 13)

        timingFunctionLabel.attributedText = formattedString
    }

    // MARK: - Buttons

    func setupButtons() {
        slowAnimationButton.setTitle("Slow Animation", for: .normal)
        slowAnimationButton.addTarget(self,
                                      action: #selector(onSlowAnimationButtonTouchUpInside(_:)),
                                      for: .touchUpInside)

        fastAnimationButton.setTitle("Fast Animation", for: .normal)
        fastAnimationButton.addTarget(self,
                                      action: #selector(onFastAnimationButtonTouchUpInside(_:)),
                                      for: .touchUpInside)

        skipAnimationButton.setTitle("Skip Animation", for: .normal)
        skipAnimationButton.addTarget(self,
                                      action: #selector(onSkipAnimationButtonTouchUpInside(_:)),
                                      for: .touchUpInside)

        changeColorButton.setTitle("Change Color", for: .normal)
        changeColorButton.addTarget(self,
                                    action: #selector(onChangeColorsButtonTouchUpInside(_:)),
                                    for: .touchUpInside)

        changeTimingFunctionButton.setTitle("Change Timing Function", for: .normal)
        changeTimingFunctionButton.addTarget(self,
                                             action: #selector(onChangeTimingFunctionButtonTouchUpInside(_:)),
                                             for: .touchUpInside)

        resetButton.setTitle("Reset to 0.00", for: .normal)
        resetButton.addTarget(self,
                              action: #selector(onResetButtonTouchUpInside(_:)),
                              for: .touchUpInside)

        // Layout buttons
        [slowAnimationButton, fastAnimationButton, skipAnimationButton, changeColorButton, changeTimingFunctionButton, resetButton]
            .forEach { (button: UIButton) in
                button.tintColor = UIColor.white
                button.titleLabel?.font = UIFont.systemFont(ofSize: 13,
                                                            weight: .semibold)

                button.contentEdgeInsets = UIEdgeInsets(top: 10.0,
                                                        left: 0.0,
                                                        bottom: 10.0,
                                                        right: 0.0)

                button.layer.cornerRadius = 4.0
                button.backgroundColor = UIColor(hex: "#4990e2")

                stackView.addArrangedSubview(button)
            }

        // Additional layout for reset button
        resetButton.backgroundColor = UIColor(hex: "#f2526e")
    }

    // MARK: - User interaction

    @objc func onSlowAnimationButtonTouchUpInside(_ sender: Any) {
        let backupAnimationDuration = progressView.animationDuration
        defer {
            progressView.animationDuration = backupAnimationDuration
        }

        progressView.animationDuration = 2.0
        progressView.setProgress(nextProgressValue, animated: true)
    }

    @objc func onFastAnimationButtonTouchUpInside(_ sender: Any) {
        progressView.setProgress(nextProgressValue, animated: true)
    }

    @objc func onSkipAnimationButtonTouchUpInside(_ sender: Any) {
        progressView.setProgress(nextProgressValue, animated: false)
    }

    @objc func onChangeColorsButtonTouchUpInside(_ sender: Any) {
        // Update state with next color scheme (which will also updates corresponding label)
        gradientColorScheme = gradientColorScheme.nextValue

        progressView.gradientColorList = gradientColorScheme.asColorList
    }

    @objc func onChangeTimingFunctionButtonTouchUpInside(_ sender: Any) {
        // Update state with next timing function (which will also updates corresponding label)
        timingFunction = timingFunction.nextValue

        progressView.timingFunction = timingFunction.asTimingFunction
    }

    @objc func onResetButtonTouchUpInside(_ sender: Any) {
        progressView.progress = 0.00
    }
}

// MARK: - Helper: Loop through enum values

// Based on: https://stackoverflow.com/a/35741424
protocol InfiniteIteration {
    static var first: Self { get }
}

extension InfiniteIteration where Self: RawRepresentable, Self.RawValue == Int {
    var nextValue: Self {
        return Self(rawValue: rawValue + 1) ?? Self.first
    }
}

// MARK: - Helper: Create attributed string with different format

/// Based on: https://stackoverflow.com/a/37992022
extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String, size: CGFloat) -> NSMutableAttributedString {
        let boldString = NSMutableAttributedString(string: text,
                                                   attributes: [ NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: size) ])
        append(boldString)

        return self
    }

    @discardableResult func normal(_ text: String, size: CGFloat) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text,
                                        attributes: [ NSAttributedStringKey.font: UIFont.systemFont(ofSize: size) ])
        append(normal)

        return self
    }
}
