//
//  CGRect+increaseByPercentage.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 01.03.17.
//  Copyright © 2017 Felix Mau. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    func sizeByPercentage(width: CGFloat, height: CGFloat = 1.0) -> CGRect {
        let width = self.width * width
        let height = self.height * height
        
        return CGRect(
            x: self.origin.x, y: self.origin.y, width: width, height: height
        )
    }
}
