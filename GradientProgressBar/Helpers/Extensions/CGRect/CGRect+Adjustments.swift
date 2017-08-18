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
    func updateWidth(byPercentage percentage: CGFloat) -> CGRect {
        return CGRect(
            x: origin.x,
            y: origin.y,
            width: size.width * percentage,
            height: size.height
        )
    }
}
