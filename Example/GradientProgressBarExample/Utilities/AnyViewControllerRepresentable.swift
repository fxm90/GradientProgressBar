//
//  AnyViewControllerRepresentable.swift
//  GradientProgressBarExample
//
//  Created by Felix Mau on 10.01.26.
//  Copyright © 2026 Felix Mau. All rights reserved.
//

import SwiftUI
import UIKit

/// A generic SwiftUI wrapper that enables the integration of UIKit view controllers.
///
/// Use this representable to host any `UIViewController` within a SwiftUI view hierarchy
/// without creating a unique `UIViewControllerRepresentable` implementation for every controller.
///
/// ### Usage
///
/// ```swift
/// struct MyView: View {
///   var body: some View {
///     AnyViewControllerRepresentable {
///       CustomUIViewController()
///     }
///     .ignoresSafeArea()
///   }
/// }
/// ```
struct AnyViewControllerRepresentable<T: UIViewController>: UIViewControllerRepresentable {
  /// A closure that initializes and returns the UIKit view controller.
  let viewControllerBuilder: () -> T

  func makeUIViewController(context _: Context) -> T {
    viewControllerBuilder()
  }

  func updateUIViewController(_: T, context _: Context) {}
}
