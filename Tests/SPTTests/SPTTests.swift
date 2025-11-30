import Foundation
@testable import SPT
@testable import SPTCore
@testable import SPTInstrumentation
import Testing

/// Test event consumer that captures events for verification
final class TestEventConsumer: SPTEventConsumer, @unchecked Sendable {
    private let lock = NSLock()
    private var _events: [SPTEvent] = []

    var events: [SPTEvent] {
        lock.lock()
        defer { lock.unlock() }
        return _events
    }

    func measurements(named name: String) -> [SPTViewBodyMeasurement] {
        events.compactMap {
            if case let .viewBodyMeasurement(m) = $0.kind, m.name == name { return m }
            return nil
        }
    }

    func handle(event: SPTEvent) {
        lock.lock()
        defer { lock.unlock() }
        _events.append(event)
    }
}

// MARK: - SPTInstrumentation Tests

@Test
func measureViewBodyEmitsEvent() async throws {
    let consumer = TestEventConsumer()
    SPTEventBus.shared.register(consumer)
    defer { SPTEventBus.shared.unregister(consumer) }

    _ = SPTInstrumentation.measureViewBody(name: "EmitTest") {
        "result"
    }

    let measurements = consumer.measurements(named: "EmitTest")
    #expect(measurements.count == 1)
    #expect(measurements.first?.name == "EmitTest")
    #expect(measurements.first?.durationMs != nil)
}

@Test
func measureViewBodyReturnsCorrectValue() async throws {
    let result = SPTInstrumentation.measureViewBody(name: "ReturnTest") {
        42
    }

    #expect(result == 42)
}

@Test
func measureViewBodyCapturesDuration() async throws {
    let consumer = TestEventConsumer()
    SPTEventBus.shared.register(consumer)
    defer { SPTEventBus.shared.unregister(consumer) }

    _ = SPTInstrumentation.measureViewBody(name: "DurationTest") {
        Thread.sleep(forTimeInterval: 0.01) // 10ms
        return "done"
    }

    let measurements = consumer.measurements(named: "DurationTest")
    #expect(measurements.count == 1)
    let duration = measurements.first?.durationMs ?? 0
    #expect(duration >= 10.0, "Expected duration >= 10ms, got \(duration)ms")
}

@Test
func multipleEventsAreCaptured() async throws {
    let consumer = TestEventConsumer()
    SPTEventBus.shared.register(consumer)
    defer { SPTEventBus.shared.unregister(consumer) }

    _ = SPTInstrumentation.measureViewBody(name: "Multi1") { "a" }
    _ = SPTInstrumentation.measureViewBody(name: "Multi2") { "b" }
    _ = SPTInstrumentation.measureViewBody(name: "Multi3") { "c" }

    #expect(consumer.measurements(named: "Multi1").count == 1)
    #expect(consumer.measurements(named: "Multi2").count == 1)
    #expect(consumer.measurements(named: "Multi3").count == 1)
}

// MARK: - SPT Configuration Tests

@Test
func configurationThresholdWorks() async throws {
    SPT.configure(.init(slowViewThreshold: 5.0, loggingEnabled: true))

    #expect(SPT.shared.configuration.slowViewThreshold == 5.0)
    #expect(SPT.shared.configuration.loggingEnabled == true)
}

@Test
func defaultConfigurationValues() async throws {
    let config = SPTConfiguration.default

    #expect(config.slowViewThreshold == 16.0)
    #expect(config.loggingEnabled == true)
}

// MARK: - SPTMeasurementType Tests

@Test
func measurementTypeViewBodyExists() async throws {
    let type: SPTMeasurementType = .viewBody
    #expect(type == .viewBody)
}
