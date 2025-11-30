//
//  ViewConstructionSample.swift
//  SPTSample
//

import SPT
import SwiftUI

/// Demonstrates measuring view construction time with SPT
struct ViewConstructionSample: View {
    @State private var fibonacciN: Double = 35
    @State private var rebuildCount = 0

    var body: some View {
        VStack(spacing: 24) {
            controlsSection

            SPTProfile(name: "FibonacciView") {
                fibonacciContent
            }

            Spacer()
        }
        .padding()
        .navigationTitle("View Construction")
    }

    private var controlsSection: some View {
        VStack(spacing: 16) {
            GroupBox("Fibonacci N: \(Int(fibonacciN))") {
                Slider(value: $fibonacciN, in: 20...42, step: 1)
            }

            Button("Recalculate") {
                rebuildCount += 1
            }
            .buttonStyle(.borderedProminent)
        }
    }

    private var fibonacciContent: some View {
        let n = Int(fibonacciN)
        let result = fibonacci(n)
        let isSlow = n > 35

        return VStack(spacing: 12) {
            Image(systemName: isSlow ? "tortoise.fill" : "hare.fill")
                .font(.system(size: 40))
                .foregroundStyle(isSlow ? .orange : .green)

            Text("fib(\(n)) = \(result)")
                .font(.system(.title2, design: .monospaced))

            Text("Calculation #\(rebuildCount)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.gray.opacity(0.1))
        .cornerRadius(12)
    }

    /// Recursive Fibonacci - intentionally slow for demonstration
    private func fibonacci(_ n: Int) -> Int {
        if n <= 1 { return n }
        return fibonacci(n - 1) + fibonacci(n - 2)
    }
}

#Preview {
    NavigationStack {
        ViewConstructionSample()
    }
}
