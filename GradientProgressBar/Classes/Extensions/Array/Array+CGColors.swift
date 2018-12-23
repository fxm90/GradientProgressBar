//
//  Array+CGColors.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 12/23/18.
//  Copyright © 2018 Felix Mau. All rights reserved.
//

import UIKit

extension Array where Element: UIColor {
    /// Converts an array of type `UIColor` to an arry of the corresponding `cgColor`.
    ///
    /// - SeeAlso: Definition of `cgColor` on `UIColor`.
    var cgColors: [CGColor] {
        return map({ $0.cgColor })
    }
}
