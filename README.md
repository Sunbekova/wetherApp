# iOS Weather App (SwiftUI)

A beautiful SwiftUI-based weather app for iOS that fetches real-time and historical weather data using [WeatherAPI.com](https://www.weatherapi.com/). Inspired by the official iPhone Weather app with a modern, glassmorphic UI and MVVM architecture.

---
Uses `https://api.weatherapi.com/v1` for all weather data (requires free API key).

---

## Features

- Live current weather data with icons
- 5-day historical forecast
- MVVM architecture using `async/await`
- Glassmorphism UI with SwiftUI
- Secure API key handling using `Keys.plist`

---

## Preview


---

## Installation

### 1. Clone the project

```bash
git clone https://github.com/Sunbekova/weatherApp-iOS.git
cd weatherApp-iOS
```


### 2. Get your API key
Register at `weatherapi.com` and generate your free API key.

### 3. Create a Keys.plist file
Inside the Xcode project folder, add a file named Keys.plist:
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
 "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>WeatherAPIKey</key>
    <string>YOUR_API_KEY_HERE</string>
</dict>
</plist>
```
This file is read securely at runtime using `AppSecrets.weatherAPIKey`

---

## Usage

To fetch and display the weather for Almaty, everything is already set up.

To change the location:
```
viewModel.fetchWeather(for: "New York")
```
Use it inside `.onAppear {}` or any button action.
Example:

```
Button {
    viewModel.fetchWeather(for: "Tokyo")
} label: {
    Image(systemName: "arrow.clockwise")
}
```

---

### Integration Notes

The app uses Swift Concurrency `(async/await)` so minimum iOS 15+ is required.
Make sure `Keys.plist` is added to your target's Bundle Resources.
No third-party dependencies – 100% native Swift.

### API Example

The app hits this endpoint under the hood:
```
https://api.weatherapi.com/v1/current.json?key=YOUR_KEY&q=Almaty&lang=ru
```

---
## Author
[@Aisha Suanbekova](https://github.com/Sunbekova)
