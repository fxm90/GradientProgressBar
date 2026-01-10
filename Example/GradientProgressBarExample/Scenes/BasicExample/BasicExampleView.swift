//
//  BasicExampleView.swift
//  GradientProgressBarExample
//
//  Created by Felix Mau on 10.01.26.
//  Copyright © 2026 Felix Mau. All rights reserved.
//

import SwiftUI

struct BasicExampleView: View {
  var body: some View {
    NavigationStack {
      AnyViewControllerRepresentable {
        BasicExampleViewController()
      }
      .navigationTitle("🏡 Basic Example")
    }
  }
}

// MARK: - Preview

#Preview {
  BasicExampleView()
}
