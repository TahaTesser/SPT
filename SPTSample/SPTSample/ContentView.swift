//
//  ContentView.swift
//  SPTSample
//
//  Created by Taha Tesser on 30.11.2025.
//

import SPT
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Measure View Construction Time") {
                    NavigationLink("View Construction") {
                        ViewConstructionSample()
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
