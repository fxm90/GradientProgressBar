//
//  GradientLayerViewModel.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 08.08.19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import Combine
import UIKit

/// This view model keeps track of the gradient-colors and updates the `gradientLayer` accordingly.
final class GradientLayerViewModel {

    // MARK: - Public properties

    /// Observable color array for the gradient layer (of type `CGColor`).
    var gradientLayerColors: AnyPublisher<[CGColor], Never> {
        gradientLayerColorsSubject
            .map { $0.map(\.cgColor) }
            .eraseToAnyPublisher()
    }

    /// Color array used for the gradient progress bar (of type `UIColor`).
    var gradientColors: [UIColor] {
        get { gradientLayerColorsSubject.value }
        set { gradientLayerColorsSubject.value = newValue }
    }

    // MARK: - Private properties

    private let gradientLayerColorsSubject: CurrentValueSubject<[UIColor], Never>
        = CurrentValueSubject(UIColor.GradientProgressBar.gradientColors)
}
