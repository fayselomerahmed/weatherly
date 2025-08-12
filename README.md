Overview:
Weatherly is a modern SwiftUI-based weather app for Apple platforms. It provides:
- Automatic weather for current location on launch
- Search/add/delete for any city
- Detailed weather and a 7-day forecast per city
- Persistent storage (cities/weather data)
- Modern UI with gradients and animation

Key Features:
1. Current location weather displayed on launch
2. Add/remove/restore multiple cities
3. Weather details with temperature, feels-like, humidity, wind, and forecast
4. Data saved/reloaded using UserDefaults (Codable)
5. Modern SwiftUI idioms and modular code

Persistence:
Weatherly uses UserDefaults. Cities and weather data are encoded/decoded with Codable, so your data is kept across launches.

Getting Started:
- Insert your OpenWeatherMap API key in WeatherService.swift
- Build and run in Xcode, allow location access
- Add cities as you like, or remove them

Extending:
- Live 7-day forecast (OpenWeatherMap OneCall)
- User settings (units, themes)
- iCloud/AppStorage storage
- Accessibility/VoiceOver polish
