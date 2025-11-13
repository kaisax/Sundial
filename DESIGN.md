# App Screenshots and UI Design

## Main Screen Layout

### Header
- **Navigation Title**: "Sundial" (large title)
- **Location Info Card**: Shows current coordinates

### Photography Times Cards

Each card displays:
- **Icon and Title**: Visual indicator (sun/moon icons) with the event name
- **Start & End Times**: Clear display of when the period begins and ends
- **Duration**: How long the period lasts in minutes
- **Description**: Brief explanation of the lighting characteristics

### Card Color Scheme

1. **Blue Hour Cards** (Blue theme)
   - Icon: moon.stars.fill
   - Gradient: Blue tones
   - Border: Blue accent

2. **Golden Hour Cards** (Orange theme)
   - Icons: sunrise.fill / sunset.fill
   - Gradient: Warm orange tones
   - Border: Orange accent

3. **Solar Noon Card** (Yellow theme)
   - Icon: sun.max.fill
   - Gradient: Yellow tones
   - Border: Yellow accent

### Date Picker
- Graphical calendar style
- Located at the bottom
- Allows users to select any future date

### Empty State (No Location)
- Large location icon
- "Location Access Required" title
- Explanatory text
- "Enable Location" button

## App Structure

```
NavigationStack
└── VStack
    ├── if locationManager.isAuthorized
    │   ├── PhotographyTimesView
    │   │   ├── Location Info Card
    │   │   ├── Morning Blue Hour Card
    │   │   ├── Morning Golden Hour Card
    │   │   ├── Solar Noon Card
    │   │   ├── Evening Golden Hour Card
    │   │   └── Evening Blue Hour Card
    │   └── DatePicker
    └── else
        └── Location Permission Request View
```

## Example Time Display

**Evening Golden Hour**
```
┌─────────────────────────────────┐
│ 🌅 Evening Golden Hour          │
├─────────────────────────────────┤
│ Start           →          End  │
│ 5:30 PM                 6:30 PM │
│                                 │
│ Duration: 60 minutes            │
│                                 │
│ The last hour before sunset     │
│ when the light is soft, warm,   │
│ and directional. Perfect for    │
│ photography.                    │
└─────────────────────────────────┘
```

## Future UI Enhancements

### Live Activities (Dynamic Island)
- Compact: Sun icon + countdown timer
- Expanded: Full event details with progress bar
- Lock Screen: Persistent notification with event info

### Widgets
- Small: Next event countdown
- Medium: Today's golden hour and blue hour times
- Large: Full schedule with all photography times

### Additional Features
- Weather overlay (cloud coverage affecting photography)
- Favorite locations for planning trips
- AR view showing sun position in real-time
- Photo gallery integration with time tagging
