//
//  StateRebuildSample.swift
//  SPTSample
//

import SPT
import SwiftUI

/// Demonstrates profiling state-driven view rebuilds
struct StateRebuildSample: View {
    @State private var counter = 0
    @State private var text = ""
    @State private var isExpanded = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("State Rebuild Sample")
                    .font(.headline)

                Text("Watch the console as state changes trigger rebuilds")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                // Counter section
                CounterSection(counter: $counter)
                    .sptProfile("CounterSection")

                // Text input section
                TextInputSection(text: $text)
                    .sptProfile("TextInputSection")

                // Expandable section
                ExpandableSection(isExpanded: $isExpanded)
                    .sptProfile("ExpandableSection")

                Spacer()
            }
            .padding()
        }
        .sptProfile("StateRebuildSample")
        .navigationTitle("State Rebuilds")
    }
}

private struct CounterSection: View {
    @Binding var counter: Int

    var body: some View {
        VStack(spacing: 12) {
            Text("Counter: \(counter)")
                .font(.title)

            HStack(spacing: 20) {
                Button("-") { counter -= 1 }
                    .buttonStyle(.bordered)

                Button("+") { counter += 1 }
                    .buttonStyle(.bordered)

                Button("Reset") { counter = 0 }
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .background(.blue.opacity(0.1))
        .cornerRadius(12)
    }
}

private struct TextInputSection: View {
    @Binding var text: String

    var body: some View {
        VStack(spacing: 12) {
            TextField("Type something...", text: $text)
                .textFieldStyle(.roundedBorder)

            Text("Characters: \(text.count)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.green.opacity(0.1))
        .cornerRadius(12)
    }
}

private struct ExpandableSection: View {
    @Binding var isExpanded: Bool

    var body: some View {
        VStack(spacing: 12) {
            Button {
                withAnimation {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text("Expandable Content")
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
            }
            .buttonStyle(.plain)

            if isExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(1...5, id: \.self) { i in
                        Text("Detail item \(i)")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding()
        .background(.orange.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    NavigationStack {
        StateRebuildSample()
    }
}
