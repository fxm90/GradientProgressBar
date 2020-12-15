#if os(macOS)
    import Cocoa

    public extension Snapshotting where Value == NSView, Format == NSImage {
        /// A snapshot strategy for comparing views based on pixel equality.
        static var image: Snapshotting {
            .image()
        }

        /// A snapshot strategy for comparing views based on pixel equality.
        ///
        /// - Parameters:
        ///   - precision: The percentage of pixels that must match.
        ///   - size: A view size override.
        static func image(precision: Float = 1, size: CGSize? = nil) -> Snapshotting {
            SimplySnapshotting.image(precision: precision).asyncPullback { view in
                let initialSize = view.frame.size
                if let size = size { view.frame.size = size }
                guard view.frame.width > 0, view.frame.height > 0 else {
                    fatalError("View not renderable to image at size \(view.frame.size)")
                }
                return view.snapshot ?? Async { callback in
                    addImagesForRenderedViews(view).sequence().run { views in
                        let bitmapRep = view.bitmapImageRepForCachingDisplay(in: view.bounds)!
                        view.cacheDisplay(in: view.bounds, to: bitmapRep)
                        let image = NSImage(size: view.bounds.size)
                        image.addRepresentation(bitmapRep)
                        callback(image)
                        views.forEach { $0.removeFromSuperview() }
                        view.frame.size = initialSize
                    }
                }
            }
        }
    }

    public extension Snapshotting where Value == NSView, Format == String {
        /// A snapshot strategy for comparing views based on a recursive description of their properties and hierarchies.
        static var recursiveDescription: Snapshotting<NSView, String> {
            SimplySnapshotting.lines.pullback { view in
                purgePointers(
                    view.perform(Selector(("_subtreeDescription"))).retain().takeUnretainedValue()
                        as! String
                )
            }
        }
    }
#endif
