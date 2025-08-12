//
//  WeatherService.swift
//  WeatherApp
//
//  Created by User on 5/25/25.
//

import Foundation
 
class WeatherService {
    let apiKey = ""
    func fetchWeatherData(for city: String) async throws -> WeatherData  {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            throw URLError(.badURL)
        }
 
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
            return decodedData
        } catch {
            print("Error decoding weather data: \(error)")
            throw error
        }
    
        // Proceed with network call here
    }
}
