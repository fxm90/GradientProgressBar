//
//  BasicExampleViewController.swift
//  GradientProgressBarExample
//
//  Created by Felix Mau on 02.02.22.
//  Copyright © 2022 Felix Mau. All rights reserved.
//

import GradientProgressBar
import UIKit

/// View controller showcasing a basic example of `GradientProgressBar`,
/// including buttons to increase, decrease and reset the progress.
final class BasicExampleViewController: UIViewController {

  // MARK: - Config

  private enum Config {
    /// Value that the progress bar is increased / decreased on each button tap.
    static let progressDelta: Float = 0.1
  }

  // MARK: - Private Properties

  private let contentStackView = UIStackView()
  private let progressLabel = UILabel()
  private let gradientProgressBar = GradientProgressBar()
  private let buttonStackView = UIStackView()

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpContentStackView()
    setUpProgressLabel()
    setUpGradientProgressBar()
    setUpButtonStackView()
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

  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .space6),
      contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.space6),
      contentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

      gradientProgressBar.heightAnchor.constraint(equalToConstant: 3),
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
  BasicExampleViewController()
}
