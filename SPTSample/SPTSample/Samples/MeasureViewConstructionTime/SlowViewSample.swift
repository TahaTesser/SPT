//
//  SlowViewSample.swift
//  SPTSample
//

import SwiftUI
import SPT

/// Demonstrates detection of slow view body computation
struct SlowViewSample: View {
    @State private var delayMs: Double = 20

    var body: some View {
        VStack(spacing: 20) {
            Text("Slow View Sample")
                .font(.headline)

            Text("Simulates slow view body with Thread.sleep")
                .font(.caption)
                .foregroundStyle(.secondary)

            GroupBox("Simulated Delay: \(Int(delayMs)) ms") {
                Slider(value: $delayMs, in: 0...100, step: 5)
            }

            SlowContentView(delayMs: delayMs)
        }
        .padding()
        .navigationTitle("Slow View")
    }
}

/// View with artificially slow body computation
private struct SlowContentView: View {
    let delayMs: Double

    var body: some View {
        // Use SPTProfile to measure work INSIDE the closure
        SPTProfile(name: "SlowContentView") {
            // Expensive work happens HERE, inside the measured closure
            let _ = {
                if delayMs > 0 {
                    Thread.sleep(forTimeInterval: delayMs / 1000.0)
                }
            }()

            VStack(spacing: 16) {
                Image(systemName: "tortoise.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.orange)

                Text("This view took ~\(Int(delayMs))ms to compute")
                    .font(.headline)

                Text("Watch the console for SPT measurements")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    NavigationStack {
        SlowViewSample()
    }
}
