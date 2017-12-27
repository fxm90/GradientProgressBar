//
//  CGRect+Adjustments.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 01.03.17.
//  Copyright © 2017 Felix Mau. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {

    /// Updates width of a `CGRect` by a given factor.
    ///
    /// Parameters:
    ///  - factor: Multiplier for the width
    ///
    /// Returns: `CGRect` with updated width.
    public func update(widthByFactor factor: CGFloat) -> CGRect {
        return CGRect(x: origin.x,
                      y: origin.y,
                      width: size.width * factor,
                      height: size.height)
    }
}
