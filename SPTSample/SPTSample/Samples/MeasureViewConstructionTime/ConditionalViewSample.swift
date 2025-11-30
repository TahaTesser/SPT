//
//  ConditionalViewSample.swift
//  SPTSample
//

import SPT
import SwiftUI

/// Demonstrates profiling conditional view rendering
struct ConditionalViewSample: View {
    @State private var viewState: ViewState = .loading

    var body: some View {
        VStack(spacing: 20) {
            Text("Conditional View Sample")
                .font(.headline)

            Picker("State", selection: $viewState) {
                ForEach(ViewState.allCases) { state in
                    Text(state.rawValue.capitalized).tag(state)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            Spacer()

            Group {
                switch viewState {
                case .loading:
                    LoadingView()
                        .sptProfile("LoadingView")
                case .empty:
                    EmptyStateView()
                        .sptProfile("EmptyStateView")
                case .content:
                    ContentStateView()
                        .sptProfile("ContentStateView")
                case .error:
                    ErrorView()
                        .sptProfile("ErrorView")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            Spacer()
        }
        .padding()
        .sptProfile("ConditionalViewSample")
        .navigationTitle("Conditional Views")
    }
}

private enum ViewState: String, CaseIterable, Identifiable {
    case loading, empty, content, error
    var id: Self { self }
}

private struct LoadingView: View {
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading...")
                .foregroundStyle(.secondary)
        }
    }
}

private struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "tray")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)
            Text("No items")
                .font(.title2)
            Text("Add some items to get started")
                .foregroundStyle(.secondary)
        }
    }
}

private struct ContentStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.green)
            Text("Content Loaded")
                .font(.title2)
            Text("Your data is ready")
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 8) {
                ForEach(1...3, id: \.self) { i in
                    HStack {
                        Image(systemName: "doc.fill")
                        Text("Document \(i)")
                    }
                }
            }
            .padding()
            .background(.gray.opacity(0.1))
            .cornerRadius(8)
        }
    }
}

private struct ErrorView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.red)
            Text("Something went wrong")
                .font(.title2)
            Text("Please try again later")
                .foregroundStyle(.secondary)
            Button("Retry") { }
                .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    NavigationStack {
        ConditionalViewSample()
    }
}
