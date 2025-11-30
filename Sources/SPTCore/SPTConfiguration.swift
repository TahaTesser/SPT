import Foundation

/// Configuration options for SPT
public struct SPTConfiguration: Sendable {
    /// Threshold in milliseconds for slow view body computation warnings
    public var slowBodyThreshold: Double

    /// Whether logging is enabled
    public var loggingEnabled: Bool

    /// Default configuration
    public static let `default` = SPTConfiguration(
        slowBodyThreshold: 16.0,
        loggingEnabled: true
    )

    public init(slowBodyThreshold: Double = 16.0, loggingEnabled: Bool = true) {
        self.slowBodyThreshold = slowBodyThreshold
        self.loggingEnabled = loggingEnabled
    }
}
