import Foundation

/// Protocol for consuming SPT events
public protocol SPTEventConsumer: AnyObject, Sendable {
    func handle(event: SPTEvent)
}

/// Central event bus for SPT events
public final class SPTEventBus: @unchecked Sendable {
    public static let shared = SPTEventBus()

    private let lock = NSLock()
    private var consumers: [SPTEventConsumer] = []

    private init() {}

    public func register(_ consumer: SPTEventConsumer) {
        lock.lock()
        defer { lock.unlock() }
        consumers.append(consumer)
    }

    public func unregister(_ consumer: SPTEventConsumer) {
        lock.lock()
        defer { lock.unlock() }
        consumers.removeAll { $0 === consumer }
    }

    public func emit(_ event: SPTEvent) {
        lock.lock()
        let current = consumers
        lock.unlock()

        current.forEach { $0.handle(event: event) }
    }
}
