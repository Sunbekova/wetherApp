//
//  WeatherView.swift
//  wetherApp
//
//  Created by Aisha Suanbekova Bakytjankyzy on 11.04.2025.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel = WeatherViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    currentWeatherSection
                    forecastSection
                }
                .padding()
            }
            .navigationTitle("Almaty Weather")
            .toolbar {
                Button("Refresh") {
                    viewModel.fetchWeather(for: "Almaty")
                }
            }
        }
        .onAppear {
            viewModel.fetchWeather(for: "Almaty")
        }
    }

    @ViewBuilder
    var currentWeatherSection: some View {
        switch viewModel.currentWeatherState {
        case .idle, .loading:
            ProgressView("Loading current weather...")
        case .success(let data):
            VStack(alignment: .leading, spacing: 8) {
                Text("Now in \(data.location.name), \(data.location.country)")
                    .font(.headline)
                Text("🌡 \(data.current.temp_c) °C")
                Text("☁️ Cloud: \(data.current.cloud)%")
                Text("💨 Wind: \(data.current.wind_kph) kph")
                AsyncImage(url: URL(string: "https:\(data.current.condition.icon)")) { image in
                    image.resizable().frame(width: 50, height: 50)
                } placeholder: {
                    ProgressView()
                }
            }
        case .failure(let error):
            Text("Error: \(error.localizedDescription)")
        }
    }

    @ViewBuilder
    var forecastSection: some View {
        switch viewModel.forecastState {
        case .idle, .loading:
            ProgressView("Loading 5-day forecast...")
        case .success(let data):
            VStack(alignment: .leading, spacing: 12) {
                Text("5-Day History").font(.headline)
                ForEach(data.forecast.forecastday, id: \.date) { day in
                    VStack(alignment: .leading) {
                        Text("📅 \(day.date)")
                        Text("🔺 Max: \(day.day.maxtemp_c) °C")
                        Text("🔻 Min: \(day.day.mintemp_c) °C")
                        Text("⚖️ Avg: \(day.day.avgtemp_c) °C")
                    }
                    .padding(.vertical, 6)
                }
            }
        case .failure(let error):
            Text("Error: \(error.localizedDescription)")
        }
    }
}
