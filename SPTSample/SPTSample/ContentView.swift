//
//  ContentView.swift
//  SPTSample
//
//  Created by Taha Tesser on 30.11.2025.
//

import SwiftUI
import SPT

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Measure View Construction Time") {
                    NavigationLink("Slow View") {
                        SlowViewSample()
                    }
                    NavigationLink("Nested Profiling") {
                        NestedProfilingSample()
                    }
                    NavigationLink("List Profiling") {
                        ListProfilingSample()
                    }
                    NavigationLink("State Rebuilds") {
                        StateRebuildSample()
                    }
                    NavigationLink("Conditional Views") {
                        ConditionalViewSample()
                    }
                }
            }
            .navigationTitle("SPT Samples")
        }
        .sptProfile("ContentView")
    }
}

#Preview {
    ContentView()
}
