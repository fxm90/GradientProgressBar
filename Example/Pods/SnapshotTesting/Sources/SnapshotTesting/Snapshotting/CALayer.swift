#if os(macOS)
    import Cocoa

    public extension Snapshotting where Value == CALayer, Format == NSImage {
        /// A snapshot strategy for comparing layers based on pixel equality.
        static var image: Snapshotting {
            .image(precision: 1)
        }

        /// A snapshot strategy for comparing layers based on pixel equality.
        ///
        /// - Parameter precision: The percentage of pixels that must match.
        static func image(precision: Float) -> Snapshotting {
            SimplySnapshotting.image(precision: precision).pullback { layer in
                let image = NSImage(size: layer.bounds.size)
                image.lockFocus()
                let context = NSGraphicsContext.current!.cgContext
                layer.setNeedsLayout()
                layer.layoutIfNeeded()
                layer.render(in: context)
                image.unlockFocus()
                return image
            }
        }
    }

#elseif os(iOS) || os(tvOS)
    import UIKit

    public extension Snapshotting where Value == CALayer, Format == UIImage {
        /// A snapshot strategy for comparing layers based on pixel equality.
        static var image: Snapshotting {
            .image()
        }

        /// A snapshot strategy for comparing layers based on pixel equality.
        ///
        /// - Parameter precision: The percentage of pixels that must match.
        static func image(precision: Float = 1, traits: UITraitCollection = .init())
            -> Snapshotting
        {
            SimplySnapshotting.image(precision: precision).pullback { layer in
                renderer(bounds: layer.bounds, for: traits).image { ctx in
                    layer.setNeedsLayout()
                    layer.layoutIfNeeded()
                    layer.render(in: ctx.cgContext)
                }
            }
        }
    }
#endif
