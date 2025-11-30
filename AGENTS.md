# **SwiftUI Performance Toolkit (SPT)**

A complete, lightweight, automated solution for SwiftUI performance monitoring, profiling, and optimization — delivered as a Swift 
Package. 

## Features
- Detect slow view-body computations

## Architecture Overview
- SwiftUI Performance Toolkit (SPT)
- Instrumentation
- Metrics & Analytics
- Output & Reporting

## Modules
- SPTCore
- SPTInstrumentation
- SPTAnalytics
- SPTOverlay
- SPTCI

## Detailed Data Flow
User View
  ↓
.sptProfile("HomeView")
  ↓
Instrumentation Layer
  ↓ timestamps, deltas, counters
Analytics Engine
  ↓ interpreted events, warnings
Overlay UI or CI Reporter
  ↓ logs, warnings, reports
Developer feedback loop

## Core API
### Initialization
`SPT.configure(.default)`

## View Profiling Modifier
```swift
struct MyView: View {
    var body: some View {
        Content()
            .sptProfile("MyView")
    }
}
```

# Commands

## SwiftLint
Run SwiftLint to check code style and conventions:
```bash
swiftlint lint --config .swiftlint.yml
```

Auto-fix correctable violations:
```bash
swiftlint lint --fix --config .swiftlint.yml
```
