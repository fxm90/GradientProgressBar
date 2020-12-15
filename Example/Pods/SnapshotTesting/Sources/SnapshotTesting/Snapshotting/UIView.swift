#if os(iOS) || os(tvOS)
    import UIKit

    public extension Snapshotting where Value == UIView, Format == UIImage {
        /// A snapshot strategy for comparing views based on pixel equality.
        static var image: Snapshotting {
            .image()
        }

        /// A snapshot strategy for comparing views based on pixel equality.
        ///
        /// - Parameters:
        ///   - drawHierarchyInKeyWindow: Utilize the simulator's key window in order to render `UIAppearance` and `UIVisualEffect`s. This option requires a host application for your tests and will _not_ work for framework test targets.
        ///   - precision: The percentage of pixels that must match.
        ///   - size: A view size override.
        ///   - traits: A trait collection override.
        static func image(drawHierarchyInKeyWindow: Bool = false,
                          precision: Float = 1,
                          size: CGSize? = nil,
                          traits: UITraitCollection = .init())
            -> Snapshotting
        {
            SimplySnapshotting.image(precision: precision).asyncPullback { view in
                snapshotView(config: .init(safeArea: .zero, size: size ?? view.frame.size, traits: .init()),
                             drawHierarchyInKeyWindow: drawHierarchyInKeyWindow,
                             traits: traits,
                             view: view,
                             viewController: .init())
            }
        }
    }

    public extension Snapshotting where Value == UIView, Format == String {
        /// A snapshot strategy for comparing views based on a recursive description of their properties and hierarchies.
        static var recursiveDescription: Snapshotting {
            Snapshotting.recursiveDescription()
        }

        /// A snapshot strategy for comparing views based on a recursive description of their properties and hierarchies.
        static func recursiveDescription(size: CGSize? = nil,
                                         traits: UITraitCollection = .init())
            -> Snapshotting<UIView, String>
        {
            SimplySnapshotting.lines.pullback { view in
                let dispose = prepareView(config: .init(safeArea: .zero, size: size ?? view.frame.size, traits: traits),
                                          drawHierarchyInKeyWindow: false,
                                          traits: .init(),
                                          view: view,
                                          viewController: .init())
                defer { dispose() }
                return purgePointers(
                    view.perform(Selector(("recursiveDescription"))).retain().takeUnretainedValue()
                        as! String
                )
            }
        }
    }
#endif
