//
//  ContentView.swift
//  GradientProgressBarExample
//
//  Created by Felix Mau on 10.01.26.
//  Copyright © 2026 Felix Mau. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      Tab("Basic", systemImage: SFSymbol.house.rawValue) {
        BasicExampleView()
      }
      Tab("Advanced", systemImage: SFSymbol.sparkles.rawValue) {
        AdvancedExampleView()
      }
      Tab("WebView", systemImage: SFSymbol.globe.rawValue) {
        WebViewExampleView()
      }
      Tab("SwiftUI", systemImage: SFSymbol.swift.rawValue) {
        SwiftUIExampleView()
      }
    }
    .overlay(alignment: .top) {
      Text("– Gradient Progress Bar Example –")
        .font(.caption)
        .accessibilityHidden(true)
    }
  }
}

// MARK: - Preview

#Preview {
  ContentView()
}
