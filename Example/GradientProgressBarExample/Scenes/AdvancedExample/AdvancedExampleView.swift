//
//  AdvancedExampleView.swift
//  GradientProgressBarExample
//
//  Created by Felix Mau on 10.01.26.
//  Copyright © 2026 Felix Mau. All rights reserved.
//

import GradientProgressBar
import SwiftUI
import UIKit

struct AdvancedExampleView: View {
  var body: some View {
    NavigationStack {
      AnyViewControllerRepresentable {
        AdvancedExampleViewController()
      }
      .navigationTitle("🚀 Advanced Example")
    }
  }
}

// MARK: - Preview

#Preview {
  AdvancedExampleView()
}
