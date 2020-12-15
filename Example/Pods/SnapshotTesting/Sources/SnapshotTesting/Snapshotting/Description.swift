public extension Snapshotting where Format == String {
    /// A snapshot strategy that captures a value's textual description from `String`'s `init(description:)`
    /// initializer.
    static var description: Snapshotting {
        SimplySnapshotting.lines.pullback(String.init(describing:))
    }
}
