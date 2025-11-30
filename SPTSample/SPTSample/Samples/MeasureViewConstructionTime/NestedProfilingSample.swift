//
//  NestedProfilingSample.swift
//  SPTSample
//

import SwiftUI
import SPT

/// Demonstrates profiling nested view hierarchies
struct NestedProfilingSample: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Nested Profiling Sample")
                .font(.headline)
            
            Text("Each section is independently profiled")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            HeaderSection()
                .sptProfile("HeaderSection")
            
            ContentSection()
                .sptProfile("ContentSection")
            
            FooterSection()
                .sptProfile("FooterSection")
            
            Spacer()
        }
        .padding()
        .sptProfile("NestedProfilingSample")
        .navigationTitle("Nested Profiling")
    }
}

private struct HeaderSection: View {
    var body: some View {
        VStack {
            Image(systemName: "star.fill")
                .font(.largeTitle)
                .foregroundStyle(.yellow)
            Text("Header")
                .font(.title2)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.blue.opacity(0.1))
        .cornerRadius(12)
    }
}

private struct ContentSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Content Section")
                .font(.title3)
            Text("This demonstrates how nested views can each have their own profiling to identify which specific section is slow.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.green.opacity(0.1))
        .cornerRadius(12)
    }
}

private struct FooterSection: View {
    var body: some View {
        HStack {
            Image(systemName: "info.circle")
            Text("Footer - Additional Info")
        }
        .font(.footnote)
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity)
        .padding()
        .background(.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    NavigationStack {
        NestedProfilingSample()
    }
}
