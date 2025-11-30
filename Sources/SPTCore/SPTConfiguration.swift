import Foundation

/// Configuration options for SPT
public struct SPTConfiguration: Sendable {
    /// Threshold in milliseconds for slow view warnings
    public var slowViewThreshold: Double

    /// Whether logging is enabled
    public var loggingEnabled: Bool

    /// Default configuration
    public static let `default` = SPTConfiguration(
        slowViewThreshold: 16.0,
        loggingEnabled: true
    )

    public init(slowViewThreshold: Double = 16.0, loggingEnabled: Bool = true) {
        self.slowViewThreshold = slowViewThreshold
        self.loggingEnabled = loggingEnabled
    }
}
