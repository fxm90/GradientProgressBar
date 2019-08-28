//
//  GradientLayerViewModel.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 08/08/19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import Foundation
import LightweightObservable

/// This view model keeps track of the gradient-colors and updates the `gradientLayer` accordingly.
final class GradientLayerViewModel {
    // MARK: - Public properties

    /// Observable color array for the gradient layer (of type `CGColor`).
    var gradientLayerColors: Observable<[CGColor]> {
        return gradientLayerColorsSubject.asObservable
    }

    /// Color array used for the gradient progress bar (of type `UIColor`).
    var gradientColors = UIColor.GradientProgressBar.gradientColors {
        didSet {
            gradientLayerColorsSubject.value = makeGradientLayerColors()
        }
    }

    // MARK: - Private properties

    private let gradientLayerColorsSubject: Variable<[CGColor]>

    // MARK: - Initializer

    init() {
        // Small workaround as calls to `self.makeGradientLayerColors()` aren't allowed before all properties have been initialized.
        gradientLayerColorsSubject = Variable([])
        gradientLayerColorsSubject.value = makeGradientLayerColors()
    }

    // MARK: - Private methods

    /// Maps the current `gradientColors` given by the user as an array of `UIColor`,
    /// to an array of type `CGColor`, so we can use it for our gradient layer.
    private func makeGradientLayerColors() -> [CGColor] {
        return gradientColors.map { $0.cgColor }
    }
}
