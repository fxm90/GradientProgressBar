//
//  WebViewExampleViewController.swift
//  GradientProgressBarExample
//
//  Created by Felix Mau on 02.02.22.
//  Copyright © 2022 Felix Mau. All rights reserved.
//

import GradientProgressBar
import SwiftUI
import UIKit
import WebKit

/// A view controller demonstrating the usage of a `GradientProgressBar`
/// to reflect the loading progress of a `WKWebView`.
///
/// Based on: <https://gist.github.com/fxm90/50d6c73d07c4d9755981b9bb4c5ab931>
final class WebViewExampleViewController: UIViewController {

  // MARK: - Config

  private enum Config {
    /// The initial URL to load in the web view.
    static let initialUrl = URL(string: "https://felix.hamburg")!
    // swiftlint:disable:previous force_unwrapping

    /// The duration of the fade-in/-out animation of the progress view.
    static let fadeDuration: TimeInterval = 0.33
  }

  // MARK: - Private Properties

  /// The web view from the interface builder.
  private let webView = WKWebView()

  /// Progress view reflecting the current loading progress of the web view.
  private let progressView = GradientProgressBar()

  /// The observation object for the progress of the web view.
  private var estimatedProgressObserver: NSKeyValueObservation?

  /// The navigation bar of the current navigation controller.
  /// Using a computed property here simplifies handling the optional value.
  private var navigationBar: UINavigationBar {
    guard let navigationBar = navigationController?.navigationBar else {
      fatalError("⚠️ – Expected view controller to be embedded in a navigation controller.")
    }

    return navigationBar
  }

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpNavigationBar()
    setUpProgressView()
    setUpWebView()
    setUpConstraints()
  }

  override func viewLayoutMarginsDidChange() {
    // Workaround to prevent the navigation bar’s large title from collapsing when the WebView finishes loading.
    // Based on: https://stackoverflow.com/a/68573703
    guard !webView.isLoading else { return }

    navigationBar.sizeToFit()
  }

  // MARK: - Private Methods

  private func setUpNavigationBar() {
    navigationBar.prefersLargeTitles = true

    navigationItem.title = "🌍 WebView Example"
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .refresh,
      target: self,
      action: #selector(refreshButtonTouchUpInside(_:)),
    )
  }

  @objc
  private func refreshButtonTouchUpInside(_: Any) {
    webView.reload()
  }

  private func setUpProgressView() {
    progressView.isHidden = true
    progressView.translatesAutoresizingMaskIntoConstraints = false
    navigationBar.addSubview(progressView)
  }

  private func setUpWebView() {
    webView.navigationDelegate = self
    webView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(webView)

    // Monitor the estimated progress of the page load using KVO.
    //
    // The KVO change handler is inferred as a `@Sendable` closure and is not guaranteed to execute on the main actor.
    // Since `progress` is main-actor isolated, we explicitly switch to the main actor using an unstructured `Task` before
    // mutating any UI state.
    estimatedProgressObserver = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
      Task { @MainActor in
        self?.progressView.progress = Float(webView.estimatedProgress)
      }
    }

    let request = URLRequest(url: Config.initialUrl)
    webView.load(request)
  }

  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      progressView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
      progressView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
      progressView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
      progressView.heightAnchor.constraint(equalToConstant: 3),

      webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      webView.topAnchor.constraint(equalTo: view.topAnchor),
      webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
}

// MARK: - `WKNavigationDelegate` conformance

/// By implementing the `WKNavigationDelegate` we can update the visibility of the `progressView`
/// according to the `WKNavigation` navigation progress.
///
/// Based on: <https://gist.github.com/fxm90/723b5def31b46035cd92a641e3b184f6>
extension WebViewExampleViewController: WKNavigationDelegate {
  func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
    if progressView.isHidden {
      // Make sure our animation is visible.
      progressView.isHidden = false
    }

    UIView.animate(
      withDuration: Config.fadeDuration,
      animations: { self.progressView.alpha = 1 },
    )
  }

  func webView(_: WKWebView, didFinish _: WKNavigation!) {
    UIView.animate(
      withDuration: Config.fadeDuration,
      animations: { self.progressView.alpha = 0 },
      completion: { isFinished in
        // Update `isHidden` flag accordingly:
        //  - set to `true` in case animation was completely finished.
        //  - set to `false` in case animation was interrupted, e.g. due to starting of another animation.
        self.progressView.isHidden = isFinished
      },
    )
  }
}

// MARK: - Preview

#Preview {
  UINavigationController(
    rootViewController: WebViewExampleViewController(),
  )
}
