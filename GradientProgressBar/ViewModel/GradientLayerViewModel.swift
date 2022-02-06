//
//  GradientLayerViewModel.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 08.08.19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import LightweightObservable
import UIKit

/// This view model keeps track of the gradient-colors and updates the `gradientLayer` accordingly.
final class GradientLayerViewModel {
    // MARK: - Public properties

    /// Observable color array for the gradient layer (of type `CGColor`).
    var gradientLayerColors: Observable<[CGColor]> {
        gradientLayerColorsSubject
    }

    /// Color array used for the gradient progress bar (of type `UIColor`).
    var gradientColors = UIColor.GradientProgressBar.gradientColors {
        didSet {
            gradientLayerColorsSubject.value = gradientColors.cgColor
        }
    }

    // MARK: - Private properties

    private let gradientLayerColorsSubject: Variable<[CGColor]>

    // MARK: - Initializer

    init() {
        gradientLayerColorsSubject = Variable(gradientColors.cgColor)
    }
}

// MARK: - Helpers

private extension Array where Element: UIColor {
    /// The Quartz color that corresponds to the color objects.
    var cgColor: [CGColor] {
        map(\.cgColor)
    }
}
