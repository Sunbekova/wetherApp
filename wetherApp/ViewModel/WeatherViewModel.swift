//
//  WeatherViewModel.swift
//  wetherApp
//
//  Created by Aisha Suanbekova Bakytjankyzy on 11.04.2025.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var currentWeatherState: LoadingState<CurrentWeatherResponse> = .idle
    @Published var forecastState: LoadingState<ForecastResponse> = .idle

    private let service = WeatherAPIService()
    
    func fetchWeather(for location: String) {
        currentWeatherState = .loading
        forecastState = .loading

        Task {
            await fetchCurrent(location)
        }

        Task {
            await fetchForecast(location)
        }
    }

    private func fetchCurrent(_ location: String) async {
        do {
            let result = try await service.fetchCurrentWeather(for: location)
            currentWeatherState = .success(result)
        } catch {
            currentWeatherState = .failure(error)
        }
    }

    private func fetchForecast(_ location: String) async {
        do {
            let result = try await service.fetchForecast(for: location)
            forecastState = .success(result)
        } catch {
            forecastState = .failure(error)
        }
    }
}
