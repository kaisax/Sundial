# Sundial

A SwiftUI iOS app for displaying photography times including golden hour, blue hour, and other important solar events for photographers.

## Features

- **Photography Times Display**: Shows the following photography-critical times:
  - Morning Blue Hour (pre-sunrise twilight)
  - Morning Golden Hour (first hour after sunrise)
  - Solar Noon (sun at highest point)
  - Evening Golden Hour (last hour before sunset)
  - Evening Blue Hour (post-sunset twilight)

- **Location-Based Calculations**: Uses your device's location to provide accurate solar calculations for your area
- **Date Selection**: Choose any date to see photography times for future planning
- **Beautiful UI**: Modern SwiftUI interface with color-coded cards for each photography time
- **Detailed Information**: Each time period includes:
  - Start and end times
  - Duration
  - Description of lighting characteristics

## Future Enhancements

- Live Activities support for real-time notifications leading up to golden hour and blue hour
- Widget support for quick glance at today's photography times
- Notifications/reminders for upcoming photography times
- Weather integration
- Favorite locations

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Location services permission

## Building

Open `Sundial.xcodeproj` in Xcode and build for iOS Simulator or device.

## Architecture

The app follows a clean SwiftUI architecture:

- **Models**: Data structures for photography times
- **Services**: 
  - `SolarCalculator`: Calculates accurate solar positions and events using NOAA algorithms
  - `LocationManager`: Manages Core Location services
- **Views**: SwiftUI views for displaying photography times

## Calculations

Solar calculations are based on NOAA Solar Position Calculator algorithms, providing accurate sunrise, sunset, and twilight times based on your geographic coordinates.
