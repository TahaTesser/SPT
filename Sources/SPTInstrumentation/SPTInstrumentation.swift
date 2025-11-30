import Foundation
import SPTCore

/// Instrumentation utilities for measuring performance
public enum SPTInstrumentation {
    /// Measures the execution time of a closure, emitting a measurement event.
    ///
    /// This times how long the closure takes to execute and return its result.
    /// It measures view hierarchy construction time (the evaluation of view expressions),
    /// not the rendering or layout phases managed by SwiftUI.
    ///
    /// - Parameters:
    ///   - name: Logical name for the measurement (e.g. "HomeView").
    ///   - bodyBuilder: Closure to measure.
    /// - Returns: The value produced by `bodyBuilder`.
    @inlinable
    public static func measureViewBody<T>(
        name: String,
        bodyBuilder: () -> T
    ) -> T {
        let start = ContinuousClock.now
        let result = bodyBuilder()
        let end = ContinuousClock.now

        let duration = end - start
        let attoseconds = Double(duration.components.attoseconds) / 1_000_000_000_000_000
        let durationMs = attoseconds + Double(duration.components.seconds) * 1000

        let measurement = SPTViewBodyMeasurement(
            name: name,
            durationMs: durationMs,
            threadName: Thread.current.name
        )

        let event = SPTEvent(kind: .viewBodyMeasurement(measurement))
        SPTEventBus.shared.emit(event)

        return result
    }
}
