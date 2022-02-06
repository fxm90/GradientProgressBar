//
//  EntryPointView.swift
//  Example
//
//  Created by Felix Mau on 02.02.22.
//  Copyright © 2022 Felix Mau. All rights reserved.
//

import SwiftUI

struct EntryPointView: View {
    // MARK: - Private properties

    @State
    private var isWebViewExampleVisible = false

    // MARK: - Render

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Example Application")) {
                    NavigationLink(destination: BasicExampleView()) {
                        TitleSubtitleView(title: "🏡 Basic Example",
                                          subtitle: "Basic usage and setup.")
                    }

                    NavigationLink(destination: AdvancedExampleView()) {
                        TitleSubtitleView(title: "🚀 Advanced Example",
                                          subtitle: "How to apply e.g. custom colors.")
                    }

                    NavigationLink(destination: SwiftUIExampleView()) {
                        TitleSubtitleView(title: "🎨 SwiftUI Example",
                                          subtitle: "How to use in a SwiftUI context.")
                    }

                    Button {
                        isWebViewExampleVisible = true
                    } label: {
                        TitleSubtitleView(title: "📲 Web View Example",
                                          subtitle: "Attach to a navigation bar.")
                            // Make entire row tappable and not just the text.
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            // We present the `WebViewExampleView` as a sheet using it's own navigation controller.
            // The `NavigationView` passed from SwiftUI isn't accessible from a `UIViewController` in a way, that we can add subviews to it.
            .sheet(isPresented: $isWebViewExampleVisible) {
                WebViewExampleView()
            }
            // Unfortunately setting the title here results in constraint warnings.
            // I couldn't find a possible fix yet, even `.navigationViewStyle(.stack)` doesn't seem to work.
            // https://stackoverflow.com/q/65316497
            .navigationTitle("GradientProgressBar")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MARK: - Subviews

private struct TitleSubtitleView: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.subheadline)
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Preview

struct EntryPointView_Previews: PreviewProvider {
    static var previews: some View {
        EntryPointView()
    }
}
