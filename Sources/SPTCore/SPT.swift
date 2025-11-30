import Foundation

/// SwiftUI Performance Toolkit main entry point
public final class SPT: @unchecked Sendable {
    /// Shared instance
    public static let shared = SPT()

    private let lock = NSLock()
    private var _configuration: SPTConfiguration = .default

    public var configuration: SPTConfiguration {
        lock.lock()
        defer { lock.unlock() }
        return _configuration
    }

    private init() {}

    /// Configure SPT with the specified configuration
    /// - Parameter configuration: The configuration to use
    public static func configure(_ configuration: SPTConfiguration) {
        shared.lock.lock()
        defer { shared.lock.unlock() }
        shared._configuration = configuration
        SPTDefaultAnalytics.ensureInitialized()
    }
}
