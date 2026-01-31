//
//  WebViewExampleView.swift
//  GradientProgressBarExample
//
//  Created by Felix Mau on 10.01.26.
//  Copyright © 2026 Felix Mau. All rights reserved.
//

import SwiftUI
import UIKit

struct WebViewExampleView: View {
  var body: some View {
    AnyViewControllerRepresentable {
      // We explicitly don't use SwiftUI's `NavigationStack` here, as the
      // `WebViewExampleViewController` needs to modify the UIKit navigation bar.
      UINavigationController(
        rootViewController: WebViewExampleViewController(),
      )
    }
    .ignoresSafeArea()
  }
}

// MARK: - Preview

#Preview {
  WebViewExampleView()
}
