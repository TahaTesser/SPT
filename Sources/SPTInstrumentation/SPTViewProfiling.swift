import SPTCore
import SwiftUI

/// Internal container view that measures the time to construct its content.
struct SPTProfiledContainer<Content: View>: View {
    private let name: String
    private let content: () -> Content

    init(name: String, @ViewBuilder content: @escaping () -> Content) {
        self.name = name
        self.content = content
    }

    var body: some View {
        SPTInstrumentation.measureViewBody(name: name) {
            content()
        }
    }
}

// MARK: - View Extension

extension View {
    /// Measures the time to construct this view within its parent's body.
    ///
    /// This modifier wraps `self` in an `SPTProfiledContainer`, timing how long it takes
    /// to evaluate this view expression. When the duration exceeds the configured
    /// `slowBodyThreshold`, a warning is logged.
    ///
    /// - Parameter name: A logical name for the measurement (e.g. "HomeView").
    /// - Returns: A profiled view that emits timing events.
    ///
    /// Example:
    /// ```swift
    /// struct HomeView: View {
    ///     var body: some View {
    ///         VStack {
    ///             HeaderView()
    ///             ContentView()
    ///         }
    ///         .sptProfile("HomeView")
    ///     }
    /// }
    /// ```
    public func sptProfile(_ name: String) -> some View {
        SPTProfiledContainer(name: name) {
            self
        }
    }
}
