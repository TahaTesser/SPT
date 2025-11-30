//
//  SPTSampleApp.swift
//  SPTSample
//
//  Created by Taha Tesser on 30.11.2025.
//

import SPT
import SwiftUI

@main
struct SPTSampleApp: App {
    init() {
        SPT.configure(.init(
            slowViewThreshold: 1.0,
            loggingEnabled: true
        ))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
