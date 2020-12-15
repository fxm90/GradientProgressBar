#if os(macOS)
    import Cocoa

    public extension Snapshotting where Value == NSViewController, Format == NSImage {
        /// A snapshot strategy for comparing view controller views based on pixel equality.
        static var image: Snapshotting {
            .image()
        }

        /// A snapshot strategy for comparing view controller views based on pixel equality.
        ///
        /// - Parameters:
        ///   - precision: The percentage of pixels that must match.
        ///   - size: A view size override.
        static func image(precision: Float = 1, size: CGSize? = nil) -> Snapshotting {
            Snapshotting<NSView, NSImage>.image(precision: precision, size: size).pullback { $0.view }
        }
    }

    public extension Snapshotting where Value == NSViewController, Format == String {
        /// A snapshot strategy for comparing view controller views based on a recursive description of their properties and hierarchies.
        static var recursiveDescription: Snapshotting {
            Snapshotting<NSView, String>.recursiveDescription.pullback { $0.view }
        }
    }
#endif
