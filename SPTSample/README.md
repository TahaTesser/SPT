# SPTSample

Sample iOS app demonstrating [SPT (SwiftUI Performance Toolkit)](https://github.com/TahaTesser/SPT) capabilities.

## Samples

### Measure View Construction Time

| Sample | Description |
|--------|-------------|
| Slow View | Detects slow view body computation using `SPTProfile` container |
| Nested Profiling | Independent profiling of nested sections using `.sptProfile()` |
| List Profiling | Profiles List vs Grid layouts using `.sptProfile()` |
| State Rebuilds | Tracks state-driven view rebuilds using `.sptProfile()` |
| Conditional Views | Profiles different view states using `.sptProfile()` |

## API Usage

### Modifier Style
```swift
ContentView()
    .sptProfile("ContentView")
```

### Container Style (for expensive work)
```swift
SPTProfile(name: "ExpensiveView") {
    let data = expensiveComputation()
    MyView(data: data)
}
```

## Running

1. Open `SPTSample.xcodeproj` in Xcode
2. Run the app
3. Navigate to samples and watch console for SPT output:
   - `📊 [SPT]` - Normal measurements
   - `⚠️ [SPT]` - Slow view warnings (exceeds threshold)
