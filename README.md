# SwiftUI Performance Toolkit (SPT)

A lightweight Swift Package for monitoring SwiftUI performance, focused on detecting slow view body computations.

## Requirements

- iOS 17.0+ / macOS 14.0+
- Swift 6.0+

## Installation

Add SPT to your project via Swift Package Manager:

1. Open your project in Xcode
2. Navigate to File > Add Package Dependencies
3. Enter the following URL:
```
https://github.com/TahaTesser/SPT.git
```

## Setup

Configure SPT early in your app lifecycle:

```swift
import SwiftUI
import SPT

@main
struct MyApp: App {
    init() {
        SPT.configure(.init(
            slowBodyThreshold: 16.0, // ms (default, ~1 frame at 60fps)
            loggingEnabled: true
        ))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

## Usage

### Measure View Construction Time

SPT measures how long it takes to construct view hierarchies (evaluate view expressions), not the rendering or layout phases managed by SwiftUI.

```swift
struct HomeView: View {
    var body: some View {
        VStack {
            HeaderView()
            ContentView()
        }
        .sptProfile("HomeView")
    }
}
```

When view construction exceeds the threshold, SPT logs a warning:

```
Slow view body: HomeView took 23.7 ms (threshold: 16.0 ms)
```

## Configuration Options

| Option | Default | Description |
|--------|---------|-------------|
| `slowBodyThreshold` | `16.0` | Duration in ms that triggers a warning |
| `loggingEnabled` | `true` | Enable/disable logging |
