import Foundation
import os.log

private let logger = Logger(subsystem: "com.spt", category: "Performance")

/// Default analytics consumer that logs slow view body computations
final class SPTDefaultAnalytics: SPTEventConsumer, @unchecked Sendable {
    static let shared = SPTDefaultAnalytics()

    private init() {
        SPTEventBus.shared.register(self)
    }

    static func ensureInitialized() {
        _ = shared
    }

    func handle(event: SPTEvent) {
        guard case let .viewBodyMeasurement(measurement) = event.kind else { return }

        let config = SPT.shared.configuration
        guard config.loggingEnabled else { return }

        let threshold = config.slowViewThreshold
        let duration = String(format: "%.2f", measurement.durationMs)

        if measurement.durationMs >= threshold {
            let name = measurement.name
            let message = "[SPT] Slow view construction: \(name) - \(duration)ms (threshold: \(threshold)ms)"
            print(message)
            logger.warning("\(message)")
        } else {
            print("[SPT] View construction: \(measurement.name) - \(duration)ms")
        }
    }
}
