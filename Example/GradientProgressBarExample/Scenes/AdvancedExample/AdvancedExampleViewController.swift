//
//  AdvancedExampleViewController.swift
//  GradientProgressBarExample
//
//  Created by Felix Mau on 02.02.22.
//  Copyright © 2022 Felix Mau. All rights reserved.
//

import GradientProgressBar
import UIKit

/// View controller showcasing advanced usage of `GradientProgressBar`,
/// including custom gradient colors, animation duration and timing function.
final class AdvancedExampleViewController: UIViewController {

  // MARK: - Config

  private enum Config {
    /// Value that the progress bar is increased / decreased on each button tap.
    static let progressDelta: Float = 0.1

    /// The custom animation duration we use.
    static let animationDuration: TimeInterval = 0.5

    /// The custom gradient colors we use.
    ///
    /// Source: <https://color.adobe.com/Pink-Flamingo-color-theme-10343714/>
    static let gradientColors = [
      #colorLiteral(red: 0.9490196078, green: 0.3215686275, blue: 0.431372549, alpha: 1), #colorLiteral(red: 0.9450980392, green: 0.4784313725, blue: 0.5921568627, alpha: 1), #colorLiteral(red: 0.9529411765, green: 0.737254902, blue: 0.7843137255, alpha: 1), #colorLiteral(red: 0.4274509804, green: 0.8666666667, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.9411764706, blue: 0.9568627451, alpha: 1),
    ]

    /// The custom timing function we use (ease-in-back).
    static let timingFunction: TimingFunction = .custom(x1: 0.6, y1: -0.28, x2: 0.735, y2: 0.045)
  }

  // MARK: - Private Properties

  private let contentStackView = UIStackView()
  private let progressLabel = UILabel()
  private let gradientProgressBar = GradientProgressBar()
  private let buttonStackView = UIStackView()
  private let descriptionLabel = UILabel()

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpContentStackView()
    setUpProgressLabel()
    setUpGradientProgressBar()
    setUpButtonStackView()
    setUpDescriptionLabel()
    setUpConstraints()

    // Initial set-up of progress label with current progress.
    updateProgressLabel()
  }

  // MARK: - Private Methods

  private func setUpContentStackView() {
    contentStackView.axis = .vertical
    contentStackView.alignment = .fill
    contentStackView.spacing = .space2
    contentStackView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(contentStackView)
  }

  private func setUpProgressLabel() {
    progressLabel.translatesAutoresizingMaskIntoConstraints = false
    contentStackView.addArrangedSubview(progressLabel)
  }

  private func setUpGradientProgressBar() {
    gradientProgressBar.gradientColors = Config.gradientColors
    gradientProgressBar.animationDuration = Config.animationDuration
    gradientProgressBar.timingFunction = Config.timingFunction
    gradientProgressBar.translatesAutoresizingMaskIntoConstraints = false
    contentStackView.addArrangedSubview(gradientProgressBar)
    contentStackView.setCustomSpacing(.space4, after: gradientProgressBar)
  }

  private func setUpButtonStackView() {
    buttonStackView.distribution = .equalSpacing
    buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    contentStackView.addArrangedSubview(buttonStackView)

    let decreaseImage = UIImage(sfSymbol: .minus)
    let decreaseButton = UIButton(
      configuration: .filled(),
      primaryAction: UIAction(image: decreaseImage) { [weak self] _ in
        guard let self else { return }

        let currentProgress = gradientProgressBar.progress
        gradientProgressBar.setProgress(currentProgress - Config.progressDelta, animated: true)
        updateProgressLabel()
      },
    )
    decreaseButton.accessibilityLabel = "Decrease progress"
    buttonStackView.addArrangedSubview(decreaseButton)

    let resetImage = UIImage(sfSymbol: .arrowCounterclockwise)
    let resetButton = UIButton(
      configuration: .filled(),
      primaryAction: UIAction(image: resetImage) { [weak self] _ in
        guard let self else { return }

        gradientProgressBar.progress = 0.5
        updateProgressLabel()
      },
    )
    resetButton.accessibilityLabel = "Reset progress"
    buttonStackView.addArrangedSubview(resetButton)

    let increaseImage = UIImage(sfSymbol: .plus)
    let increaseButton = UIButton(
      configuration: .filled(),
      primaryAction: UIAction(image: increaseImage) { [weak self] _ in
        guard let self else { return }

        let currentProgress = gradientProgressBar.progress
        gradientProgressBar.setProgress(currentProgress + Config.progressDelta, animated: true)
        updateProgressLabel()
      },
    )
    increaseButton.accessibilityLabel = "Increase progress"
    buttonStackView.addArrangedSubview(increaseButton)
  }

  private func setUpDescriptionLabel() {
    descriptionLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
    descriptionLabel.numberOfLines = 0
    descriptionLabel.textAlignment = .center
    descriptionLabel.text = """
    Example scene showing custom
    gradient colors, duration and timing function.
    """
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(descriptionLabel)
  }

  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .space6),
      contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.space6),
      contentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

      gradientProgressBar.heightAnchor.constraint(equalToConstant: 3),

      // To avoid layout jumps when switching between the basic- and advanced example scenes,
      // we position the description label below the content stack view.
      descriptionLabel.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: .space5),
      descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .space6),
      descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.space6),
    ])
  }

  private func updateProgressLabel() {
    let formattedProgress = gradientProgressBar.progress.formatted(
      .percent.precision(.fractionLength(0)),
    )
    var attributedString = AttributedString("Progress: \(formattedProgress)")

    let calloutFont = UIFont.preferredFont(forTextStyle: .callout)
    attributedString.uiKit.font = calloutFont

    if let boldRange = attributedString.range(of: formattedProgress) {
      attributedString[boldRange].uiKit.font = calloutFont.withWeight(.semibold)
    }

    progressLabel.attributedText = NSAttributedString(attributedString)
  }
}

// MARK: - Helper

private extension UIFont {
  /// Creates a new `UIFont` by applying the given weight to the receiver’s font descriptor.
  /// The original font is not modified.
  func withWeight(_ weight: UIFont.Weight) -> UIFont {
    let descriptor = fontDescriptor.addingAttributes([
      .traits: [UIFontDescriptor.TraitKey.weight: weight],
    ])

    return UIFont(descriptor: descriptor, size: pointSize)
  }
}

// MARK: - Preview

#Preview {
  AdvancedExampleViewController()
}
