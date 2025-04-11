//
//  WeatherAPIService.swift
//  wetherApp
//
//  Created by Aisha Suanbekova Bakytjankyzy on 11.04.2025.
//

import Foundation

enum WeatherAPIError: Error {
    case invalidURL, requestFailed, decodingFailed
}

class WeatherAPIService {
    private let apiKey = AppSecrets.weatherAPIKey //take ApiKey From Api by registration
    let baseURL = "https://api.weatherapi.com/v1"

    func fetchCurrentWeather(for location: String) async throws -> CurrentWeatherResponse {
        let urlString = "\(baseURL)/current.json?key=\(apiKey)&q=\(location)&lang=ru"
        guard let url = URL(string: urlString) else { throw WeatherAPIError.invalidURL }

        let (data, _) = try await URLSession.shared.data(from: url)
        guard let decoded = try? JSONDecoder().decode(CurrentWeatherResponse.self, from: data) else {
            throw WeatherAPIError.decodingFailed
        }
        return decoded
    }

    func fetchForecast(for location: String, days: Int = 5) async throws -> ForecastResponse {
        let end = getNDaysAgo(daysBack: -days + 1)
        let start = getNDaysAgo(daysBack: 1)
        let urlString = "\(baseURL)/history.json?key=\(apiKey)&q=\(location)&dt=\(start)&end_dt=\(end)&lang=ru"
        guard let url = URL(string: urlString) else { throw WeatherAPIError.invalidURL }

        let (data, _) = try await URLSession.shared.data(from: url)
        guard let decoded = try? JSONDecoder().decode(ForecastResponse.self, from: data) else {
            throw WeatherAPIError.decodingFailed
        }
        return decoded
    }

    private func getNDaysAgo(daysBack: Int) -> String {
        let date = Calendar.current.date(byAdding: .day, value: -daysBack, to: Date()) ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
