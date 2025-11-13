# Quick Start Guide

Get started with the Sundial photography times app in just a few steps!

## Prerequisites

- macOS with Xcode 15.0 or later
- iOS 17.0+ simulator or device
- Basic knowledge of Swift and SwiftUI

## Getting Started

### 1. Open the Project

```bash
# Navigate to the project directory
cd Sundial

# Open in Xcode
open Sundial.xcodeproj
```

### 2. Build and Run

1. In Xcode, select your target device:
   - **iPhone 15** simulator (recommended for testing)
   - Or any physical iPhone with iOS 17+

2. Press **⌘R** or click the **Run** button

3. The app will build and launch

### 3. First Launch

When you first launch the app:

1. You'll see a **"Location Access Required"** screen
2. Tap **"Enable Location"** button
3. iOS will prompt for location permission
4. Select **"Allow While Using App"**
5. The app will automatically detect your location and calculate photography times

### 4. Using the App

**View Today's Photography Times:**
- The main screen shows all photography times for today
- Each card displays start time, end time, and duration

**Plan for Future Dates:**
- Use the date picker at the bottom to select any future date
- Photography times update automatically

**Photography Times Shown:**
- 🌙 Morning Blue Hour
- 🌅 Morning Golden Hour  
- ☀️ Solar Noon
- 🌇 Evening Golden Hour
- 🌙 Evening Blue Hour

## Project Structure

```
Sundial/
├── SundialApp.swift              # App entry point
├── ContentView.swift             # Main view with location handling
├── PhotographyTimesView.swift    # Photography times display
├── Models/
│   └── PhotographyTime.swift     # Data model
└── Services/
    ├── SolarCalculator.swift     # Solar calculations
    └── LocationManager.swift     # Location services
```

## Making Changes

### Modify UI Colors

Edit the color properties in `PhotographyTimesView.swift`:

```swift
// Change golden hour color from orange to red
color: .red  // was .orange
```

### Adjust Time Calculations

Modify the solar angle calculations in `SolarCalculator.swift`:

```swift
// Change golden hour duration from 1 hour to 2 hours
return calendar.date(byAdding: .hour, value: 2, to: sunrise)
```

### Add New Features

Follow the guides in:
- `LIVE_ACTIVITIES.md` for Live Activities
- `TODO.md` for feature checklist
- `DESIGN.md` for UI guidelines

## Testing Different Locations

### In Simulator:

1. Open **Xcode → Debug → Simulate Location**
2. Choose a preset location:
   - Apple Park (California)
   - London, England
   - Tokyo, Japan
   - Custom coordinates

3. Watch photography times update

### Common Test Locations:

```swift
// Equator (always ~12h day/night)
Latitude: 0.0, Longitude: 0.0

// Arctic Circle (midnight sun/polar night)
Latitude: 66.5, Longitude: 0.0

// San Francisco (varied times)
Latitude: 37.7749, Longitude: -122.4194
```

## Troubleshooting

### "Location Access Required" won't go away
- Check: System Settings → Privacy & Security → Location Services
- Ensure Location Services are enabled globally
- Reset location permissions: Settings → General → Transfer or Reset iPhone → Reset → Reset Location & Privacy

### Times seem incorrect
- Verify your device time zone is correct
- Check location accuracy (should be within ~100m)
- Calculations are in local timezone

### App won't build
- Ensure Xcode 15+ is installed
- Clean build folder: Product → Clean Build Folder (⇧⌘K)
- Delete derived data: Window → Organizer → Projects → Delete Derived Data

## Next Steps

1. ✅ Build and run the app successfully
2. 📱 Test on different locations
3. 🔔 Implement Live Activities (see LIVE_ACTIVITIES.md)
4. 📊 Add widgets
5. 🌤️ Integrate weather data
6. 🚀 Publish to App Store

## Resources

- **Apple Developer Documentation**: https://developer.apple.com/documentation/swiftui
- **NOAA Solar Calculator**: https://gml.noaa.gov/grad/solcalc/
- **Photography Light Reference**: https://www.photoephemeris.com/

## Need Help?

- Check `README.md` for detailed documentation
- Review `TODO.md` for implementation checklist
- See `DESIGN.md` for UI specifications
- Read `LIVE_ACTIVITIES.md` for Live Activities guide

Happy photographing! 📸
