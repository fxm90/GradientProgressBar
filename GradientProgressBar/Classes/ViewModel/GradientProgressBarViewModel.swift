//
//  GradientProgressBarViewModel.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 20.01.18.
//

import Foundation

// MARK: - Delegate

protocol GradientProgressBarViewModelDelegate: class {

    /// Informs the delegate about an update of the frame used for the alpha layer.
    ///
    /// - Parameters:
    ///   - viewModel: The view model related to the update.
    ///   - frame: The new frame for the alpha layer.
    ///   - animationDuration: The time interval the changes should be applied with.
    ///   - timingFunction: The timing function the changes should be applied with.
    func viewModel(_: GradientProgressBarViewModel,
                   didUpdateAlphaLayerFrame frame: CGRect,
                   animationDuration: TimeInterval?,
                   timingFunction: CAMediaTimingFunction?)

    /// Informs the delegate about an update of the frame used for the gradient layer.
    ///
    /// - Parameters:
    ///   - viewModel: The view model related to the update.
    ///   - frame: The new frame for the gradient layer.
    func viewModel(_: GradientProgressBarViewModel, didUpdateGradientLayerFrame frame: CGRect)

    /// Informs the delegate about an update of the colors for the gradient layer.
    ///
    /// - Parameters:
    ///   - viewModel: The view model related to the update.
    ///   - colorList: The new color list for the gradient layer.
    func viewModel(_: GradientProgressBarViewModel, didUpdateGradientLayerColorList colorList: [UIColor])
}

private extension GradientProgressBarViewModelDelegate {

    /// Informs the delegate about an update of the frame used for the alpha layer.
    ///
    /// Note:
    ///  - Same as defined in protocol, but with default parameters
    func viewModel(_ vm: GradientProgressBarViewModel,
                   didUpdateAlphaLayerFrame frame: CGRect,
                   animationDuration: TimeInterval? = nil,
                   timingFunction: CAMediaTimingFunction? = nil) {
        viewModel(vm,
                  didUpdateAlphaLayerFrame: frame,
                  animationDuration: animationDuration,
                  timingFunction: timingFunction)
    }
}

// MARK: - View Model

class GradientProgressBarViewModel {

    weak var delegate: GradientProgressBarViewModelDelegate?

    /// Bounds for the progress bar.
    var bounds = CGRect.zero {
        didSet {
            // Workaround to handle orientation change, as `layoutSubviews()` gets triggered each time
            // the progress value is changed.
            delegate?.viewModel(self, didUpdateGradientLayerFrame: bounds)
            delegate?.viewModel(self, didUpdateAlphaLayerFrame: alphaLayerFrameForProgress)
        }
    }

    /// Current progress value.
    var progress: Float = 0.0 {
        didSet {
            // Update layer mask on direct changes to progress value.
            delegate?.viewModel(self, didUpdateAlphaLayerFrame: alphaLayerFrameForProgress)
        }
    }

    /// Gradient colors for the progress view.
    var gradientColorList: [UIColor]? {
        didSet {
            updateGradientColors()
        }
    }

    /// Animation duration for animated progress change.
    public var animationDuration: TimeInterval?

    /// Animation timing function for animated progress change.
    public var timingFunction: CAMediaTimingFunction?

    // MARK: - Private helper

    /// Frame for alpha layer based on current progress value.
    private var alphaLayerFrameForProgress: CGRect {
        var frame = bounds
        frame.size.width *= CGFloat(progress)

        return frame
    }

    /// Determines current gradient colors and informs the delegate to update them.
    private func updateGradientColors() {
        let gradientColorList = self.gradientColorList ?? GradientProgressBar.DefaultValues.gradientColorList
        delegate?.viewModel(self, didUpdateGradientLayerColorList: gradientColorList)
    }

    /// Bypass the delegate until completion call is finished.
    private func bypassDelegate(completion: () -> Void) {
        let backupDelegate = delegate
        defer {
            delegate = backupDelegate
        }

        delegate = nil
        completion()
    }

    // MARK: - Public methods

    /// Initializes view model for given bounds.
    ///
    /// Note:
    ///  - This method has to be called after setting a valid delegate!
    func setup(forBounds bounds: CGRect) {
        self.bounds = bounds

        updateGradientColors()
    }

    /// Adjusts the current progress.
    func setProgress(_ progress: Float, animated: Bool) {
        guard animated else {
            // Changes should be applied immediately, therefore set progress directly and
            // inform delegate via `didSet` property observer.
            self.progress = progress
            return
        }

        // Changes should be applied WITH animation, therefore prevent calling the delegate via progress `didSet` property observer,
        // as this would lead to an direct update.
        bypassDelegate {
            self.progress = progress
        }

        let animationDuration = self.animationDuration ?? GradientProgressBar.DefaultValues.animationDuration
        delegate?.viewModel(self,
                            didUpdateAlphaLayerFrame: alphaLayerFrameForProgress,
                            animationDuration: animationDuration,
                            timingFunction: timingFunction)
    }
}
