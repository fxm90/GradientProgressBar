//
//  NSObject+Builder.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 03.10.21.
//  Copyright © 2021 Felix Mau. All rights reserved.
//

import Foundation

protocol Builder {}

extension Builder {
    func set<T>(_ keyPath: WritableKeyPath<Self, T>, to value: T) -> Self {
        var mutableCopy = self
        mutableCopy[keyPath: keyPath] = value

        return mutableCopy
    }
}

extension NSObject: Builder {}
