//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by User on 5/25/25.
//

import Foundation
@MainActor
class WeatherViewModel : ObservableObject {
    @Published var weather: WeatherData?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    private let service = WeatherService()
    init() {
        
    }
    func loadWeather(for city: String) async {
        isLoading = true
        errorMessage = nil
        do {
            let fetchedWeather = try await service.fetchWeatherData(for: city)
            self.weather = fetchedWeather
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
