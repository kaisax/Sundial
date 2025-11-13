# Implementation Checklist

This checklist will help you implement and extend the Sundial app.

## ✅ Completed

- [x] Created Xcode project structure
- [x] Implemented SolarCalculator with NOAA algorithms
- [x] Created LocationManager for location services
- [x] Built main ContentView with location permission handling
- [x] Created PhotographyTimesView with all photography times
- [x] Designed color-coded UI cards for each time period
- [x] Added date picker for future planning
- [x] Configured Info.plist with location permissions
- [x] Added .gitignore for Xcode projects
- [x] Created comprehensive documentation

## 📱 To Build and Test

- [ ] Open Sundial.xcodeproj in Xcode
- [ ] Select iPhone simulator or physical device
- [ ] Build and run the project (⌘R)
- [ ] Grant location permissions when prompted
- [ ] Verify all photography times are displayed correctly
- [ ] Test date picker functionality
- [ ] Test on different locations (can simulate in Xcode)

## 🔔 Live Activities Implementation

- [ ] Add ActivityKit framework support
- [ ] Create PhotographyActivityAttributes.swift
- [ ] Update Info.plist with Live Activities keys
- [ ] Add Widget Extension target
- [ ] Implement SundialWidgetLiveActivity
- [ ] Design Dynamic Island UI components
- [ ] Add "Start Live Activity" buttons to UI
- [ ] Test on physical iPhone 14 Pro or newer
- [ ] Handle activity lifecycle (start/update/end)

## 📊 Widget Support

- [ ] Add Widget Extension (if not added for Live Activities)
- [ ] Create small widget (next event countdown)
- [ ] Create medium widget (golden + blue hour times)
- [ ] Create large widget (full day schedule)
- [ ] Add widget configuration options
- [ ] Test widget refresh intervals

## 🔔 Notifications

- [ ] Request notification permissions
- [ ] Schedule notifications for upcoming photography times
- [ ] Allow users to configure notification timing (e.g., 30 min before)
- [ ] Add notification actions (dismiss, snooze)
- [ ] Handle notification taps to open specific times

## 🌤️ Weather Integration

- [ ] Integrate WeatherKit API
- [ ] Display cloud coverage on photography time cards
- [ ] Add weather-based recommendations
- [ ] Show weather alerts that might affect photography
- [ ] Add UV index for safety

## 📍 Favorite Locations

- [ ] Add location search functionality
- [ ] Allow saving favorite locations
- [ ] Show photography times for multiple locations
- [ ] Add location-based notes

## 🎨 UI Enhancements

- [ ] Add app icon
- [ ] Design launch screen
- [ ] Add haptic feedback
- [ ] Implement dark mode optimizations
- [ ] Add accessibility labels for VoiceOver
- [ ] Support Dynamic Type

## 📷 Advanced Features

- [ ] AR view showing sun position in sky
- [ ] Photo gallery integration
- [ ] Share photography times via messages/social
- [ ] Export calendar events for photography times
- [ ] Moon phase tracking
- [ ] Milky Way visibility calculator

## 🧪 Testing

- [ ] Write unit tests for SolarCalculator
- [ ] Write UI tests for main flows
- [ ] Test edge cases (Arctic Circle, Equator, etc.)
- [ ] Test different time zones
- [ ] Performance testing
- [ ] Battery usage testing (especially with Live Activities)

## 🚀 App Store Preparation

- [ ] Create App Store Connect listing
- [ ] Design App Store screenshots
- [ ] Write App Store description
- [ ] Prepare privacy policy
- [ ] Configure app capabilities
- [ ] Add support URL
- [ ] Submit for App Store review

## 📝 Future Ideas

- [ ] Apple Watch companion app
- [ ] iCloud sync for favorites
- [ ] Photography tips based on conditions
- [ ] Social features (share locations)
- [ ] Integration with camera apps
- [ ] Offline mode with cached calculations
- [ ] Landscape mode support for iPad

## 🐛 Known Considerations

- Solar calculations are accurate to within a few minutes
- Blue hour angles (4-6°) are approximate and may vary
- Golden hour is defined as 1 hour for simplicity
- Location accuracy depends on device GPS
- Atmospheric refraction not fully modeled
- No support for polar day/night currently
