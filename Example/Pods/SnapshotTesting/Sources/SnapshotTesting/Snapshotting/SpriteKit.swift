#if os(iOS) || os(macOS) || os(tvOS)
    import SpriteKit
    #if os(macOS)
        import Cocoa
    #elseif os(iOS) || os(tvOS)
        import UIKit
    #endif

    #if os(macOS)
        public extension Snapshotting where Value == SKScene, Format == NSImage {
            /// A snapshot strategy for comparing SpriteKit scenes based on pixel equality.
            ///
            /// - Parameters:
            ///   - precision: The percentage of pixels that must match.
            ///   - size: The size of the scene.
            static func image(precision: Float = 1, size: CGSize) -> Snapshotting {
                .skScene(precision: precision, size: size)
            }
        }

    #elseif os(iOS) || os(tvOS)
        public extension Snapshotting where Value == SKScene, Format == UIImage {
            /// A snapshot strategy for comparing SpriteKit scenes based on pixel equality.
            ///
            /// - Parameters:
            ///   - precision: The percentage of pixels that must match.
            ///   - size: The size of the scene.
            static func image(precision: Float = 1, size: CGSize) -> Snapshotting {
                .skScene(precision: precision, size: size)
            }
        }
    #endif

    fileprivate extension Snapshotting where Value == SKScene, Format == Image {
        static func skScene(precision: Float, size: CGSize) -> Snapshotting {
            Snapshotting<View, Image>.image(precision: precision).pullback { scene in
                let view = SKView(frame: .init(x: 0, y: 0, width: size.width, height: size.height))
                view.presentScene(scene)
                return view
            }
        }
    }
#endif
