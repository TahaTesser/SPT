import Foundation

/// Types of measurements SPT can perform
public enum SPTMeasurementType: Sendable {
    /// Measures view body construction time
    case viewBody
    // Future: case renderTime, case layoutPass, etc.
}

/// Payload for view-body measurements
public struct SPTViewBodyMeasurement: Sendable {
    public let name: String
    public let durationMs: Double
    public let threadName: String?

    public init(name: String, durationMs: Double, threadName: String? = nil) {
        self.name = name
        self.durationMs = durationMs
        self.threadName = threadName
    }
}

/// High-level event types emitted by SPT
public enum SPTEventKind: Sendable {
    case viewBodyMeasurement(SPTViewBodyMeasurement)
}

/// Event envelope
public struct SPTEvent: Sendable {
    public let kind: SPTEventKind
    public let timestamp: Date

    public init(kind: SPTEventKind, timestamp: Date = Date()) {
        self.kind = kind
        self.timestamp = timestamp
    }
}
