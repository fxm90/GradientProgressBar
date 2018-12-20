//
//  WebViewExampleViewController.swift
//  GradientProgressBar_Example
//
//  Created by Felix Mau on 23.09.18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import WebKit
import GradientProgressBar

class WebViewExampleViewController: UIViewController {
    // MARK: - Outlets

    /// The web view from the interface builder.
    @IBOutlet var webView: WKWebView!

    // MARK: - Private properties

    /// Progress view reflecting the current loading progress of the web view.
    let progressView = GradientProgressBar()

    /// The observation object for the progress of the web view (we only receive notifications until it is deallocated).
    private var estimatedProgressObserver: NSKeyValueObservation?

    // MARK: - Public methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupProgressView()
        setupEstimatedProgressObserver()

        if let initialUrl = URL(string: "https://felix.hamburg") {
            setupWebview(url: initialUrl)
        }
    }

    // MARK: - Private methods

    private func setupProgressView() {
        guard let navigationBar = navigationController?.navigationBar else { return }

        progressView.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(progressView)

        progressView.isHidden = true

        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),

            progressView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 2.0)
        ])
    }

    private func setupEstimatedProgressObserver() {
        estimatedProgressObserver = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
            self?.progressView.progress = Float(webView.estimatedProgress)
        }
    }

    private func setupWebview(url: URL) {
        let request = URLRequest(url: url)

        webView.navigationDelegate = self
        webView.load(request)
    }

    @IBAction private func refreshButtonTouchUpInside(_: Any) {
        webView.reload()
    }
}

// MARK: - WKNavigationDelegate

/// By implementing the `WKNavigationDelegate` we can update the visibility of the `progressView` according to the `WKNavigation` loading progress.
/// The view-visibility updates are based on my gist [fxm90/UIView+AnimateIsHidden.swift](https://gist.github.com/fxm90/723b5def31b46035cd92a641e3b184f6)
extension WebViewExampleViewController: WKNavigationDelegate {
    func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
        if progressView.isHidden {
            // Make sure our animation is visible.
            progressView.isHidden = false
        }

        UIView.animate(withDuration: 0.33,
                       animations: {
                           self.progressView.alpha = 1.0
        })
    }

    func webView(_: WKWebView, didFinish _: WKNavigation!) {
        UIView.animate(withDuration: 0.33,
                       animations: {
                           self.progressView.alpha = 0.0
                       },
                       completion: { isFinished in
                           // Update `isHidden` flag accordingly:
                           //  - set to `true` in case animation was completly finished.
                           //  - set to `false` in case animation was interrupted, e.g. due to starting of another animation.
                           self.progressView.isHidden = isFinished
        })
    }
}
