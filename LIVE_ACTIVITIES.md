# Live Activities Implementation Guide

This document outlines how to implement Live Activities for the Sundial app to provide real-time updates leading up to golden hour and blue hour.

## Overview

Live Activities will allow users to see a persistent notification on their lock screen and Dynamic Island showing:
- Countdown to the next golden hour or blue hour
- Current lighting conditions
- Progress indicator showing how close we are to the target time

## Implementation Steps

### 1. Create Activity Attributes

Create a new file `PhotographyActivityAttributes.swift`:

```swift
import ActivityKit
import Foundation

struct PhotographyActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var eventName: String
        var startTime: Date
        var endTime: Date
        var currentProgress: Double
    }
    
    var eventType: String // "golden_hour" or "blue_hour"
    var location: String
}
```

### 2. Update Info.plist

Add the following keys to `Info.plist`:

```xml
<key>NSSupportsLiveActivities</key>
<true/>
<key>NSSupportsLiveActivitiesFrequentUpdates</key>
<true/>
```

### 3. Create Widget Extension

1. Add a new Widget Extension target to the project:
   - File > New > Target > Widget Extension
   - Name it "SundialWidget"
   - Include "Live Activity" option

2. Implement the Live Activity widget in `SundialWidgetLiveActivity.swift`:

```swift
import ActivityKit
import WidgetKit
import SwiftUI

struct SundialWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PhotographyActivityAttributes.self) { context in
            // Lock screen/banner UI
            LockScreenLiveActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI
                DynamicIslandExpandedRegion(.leading) {
                    leadingView(context: context)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    trailingView(context: context)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    bottomView(context: context)
                }
            } compactLeading: {
                compactLeadingView(context: context)
            } compactTrailing: {
                compactTrailingView(context: context)
            } minimal: {
                minimalView(context: context)
            }
        }
    }
}
```

### 4. Start Live Activity from Main App

Add this to your view where you want to start the Live Activity:

```swift
import ActivityKit

func startLiveActivity(for time: PhotographyTime) {
    guard ActivityAuthorizationInfo().areActivitiesEnabled else {
        print("Live Activities are not enabled")
        return
    }
    
    let attributes = PhotographyActivityAttributes(
        eventType: time.name.contains("Golden") ? "golden_hour" : "blue_hour",
        location: "Current Location"
    )
    
    let contentState = PhotographyActivityAttributes.ContentState(
        eventName: time.name,
        startTime: time.startTime ?? Date(),
        endTime: time.endTime ?? Date(),
        currentProgress: 0.0
    )
    
    do {
        let activity = try Activity<PhotographyActivityAttributes>.request(
            attributes: attributes,
            contentState: contentState,
            pushType: nil
        )
        print("Live Activity started: \(activity.id)")
    } catch {
        print("Error starting Live Activity: \(error)")
    }
}
```

### 5. Update Live Activity

Update the activity as time progresses:

```swift
Task {
    for await activity in Activity<PhotographyActivityAttributes>.activityUpdates {
        let progress = calculateProgress(
            start: activity.attributes.startTime,
            end: activity.attributes.endTime
        )
        
        let updatedState = PhotographyActivityAttributes.ContentState(
            eventName: activity.contentState.eventName,
            startTime: activity.contentState.startTime,
            endTime: activity.contentState.endTime,
            currentProgress: progress
        )
        
        await activity.update(using: updatedState)
    }
}
```

### 6. End Live Activity

End the activity when the event is over:

```swift
Task {
    await activity.end(dismissalPolicy: .default)
}
```

## UI Design Recommendations

### Lock Screen View
- Display event name (e.g., "Evening Golden Hour")
- Show countdown timer to start time
- Progress bar showing time until event
- Icon representing sun position

### Dynamic Island Views

**Compact Leading:**
- Sun icon with color matching event type (orange for golden, blue for blue hour)

**Compact Trailing:**
- Countdown timer showing minutes until event

**Minimal:**
- Animated sun icon

**Expanded:**
- Event name and description
- Countdown to start and end times
- Visual representation of sun position
- "Get Ready" indicator when event is about to start

## Testing

1. Test on physical device (Live Activities don't work in simulator for Dynamic Island)
2. Verify battery impact
3. Test with different event types
4. Ensure proper cleanup when events end

## Future Enhancements

- Push notifications for remote updates
- Weather integration in Live Activity
- Multiple concurrent activities for different events
- Historical tracking of which activities were most useful
