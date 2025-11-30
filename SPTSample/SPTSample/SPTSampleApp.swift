//
//  SPTSampleApp.swift
//  SPTSample
//
//  Created by Taha Tesser on 30.11.2025.
//

import SwiftUI
import SPT

@main
struct SPTSampleApp: App {
    init() {
        SPT.configure(.init(
            slowBodyThreshold: 1.0,
            loggingEnabled: true
        ))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
