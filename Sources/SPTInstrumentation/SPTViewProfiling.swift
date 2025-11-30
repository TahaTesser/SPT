import SPTCore
import SwiftUI

/// Container that profiles its content based on the specified measurement type.
///
/// Use this when you need to measure work during view body evaluation:
/// ```swift
/// SPTProfile(name: "ExpensiveView") {
///     let data = expensiveComputation()
///     MyView(data: data)
/// }
/// ```
public struct SPTProfile<Content: View>: View {
    private let name: String
    private let measuring: SPTMeasurementType
    private let content: () -> Content

    public init(
        name: String,
        measuring: SPTMeasurementType = .viewBody,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.name = name
        self.measuring = measuring
        self.content = content
    }

    public var body: some View {
        switch measuring {
        case .viewBody:
            SPTInstrumentation.measureViewBody(name: name) {
                content()
            }
        }
    }
}

// MARK: - View Extension

extension View {
    /// Profiles this view with the specified measurement type.
    ///
    /// - Parameters:
    ///   - name: A logical name for the measurement (e.g. "HomeView").
    ///   - measuring: The type of measurement to perform. Defaults to `.viewBody`.
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
    public func sptProfile(_ name: String, measuring: SPTMeasurementType = .viewBody) -> some View {
        SPTProfile(name: name, measuring: measuring) {
            self
        }
    }
}
