import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel = WeatherViewModel()

    var body: some View {
        ZStack {
            // Background
            backgroundView

            ScrollView {
                VStack(spacing: 30) {
                    if case .success(let data) = viewModel.currentWeatherState {
                        currentWeatherMain(data)
                    } else {
                        currentWeatherCard
                    }

                    forecastCard
                }
                .padding()
            }
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.fetchWeather(for: "Almaty")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.fetchWeather(for: "Almaty")
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
    }

    // MARK: - Background Gradient (static here, could be dynamic per condition)
    var backgroundView: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.indigo]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .blur(radius: 40)
    }

    // MARK: - Main Current Weather Display
    func currentWeatherMain(_ data: CurrentWeatherResponse) -> some View {
        VStack(spacing: 16) {
            Text(data.location.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)

            AsyncImage(url: URL(string: "https:\(data.current.condition.icon)")) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
            }

            Text(data.current.condition.text)
                .font(.title3)
                .foregroundColor(.white)

            Text("\(data.current.temp_c, specifier: "%.0f")°")
                .font(.system(size: 80, weight: .thin))
                .foregroundColor(.white)

            HStack(spacing: 30) {
                Label("\(data.current.wind_kph, specifier: "%.0f") kph", systemImage: "wind")
                Label("\(data.current.cloud)%", systemImage: "cloud.fill")
            }
            .foregroundColor(.white.opacity(0.9))
            .font(.subheadline)
        }
        .padding(.top, 50)
    }

    // MARK: - Card Style Wrapper
    func glassCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .shadow(radius: 5)
    }

    // MARK: - Fallback current card
    @ViewBuilder
    var currentWeatherCard: some View {
        switch viewModel.currentWeatherState {
        case .idle, .loading:
            glassCard {
                ProgressView("Loading current weather…")
            }

        case .failure(let error):
            glassCard {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                    Text("Error: \(error.localizedDescription)")
                }
                .foregroundColor(.white)
            }

        default: EmptyView()
        }
    }

    // MARK: - Forecast Card
    @ViewBuilder
    var forecastCard: some View {
        switch viewModel.forecastState {
        case .idle, .loading:
            glassCard {
                ProgressView("Loading 5-day forecast…")
            }

        case .success(let data):
            glassCard {
                VStack(alignment: .leading, spacing: 10) {
                    Text("5-Day Forecast")
                        .font(.headline)
                        .foregroundColor(.white)

                    ForEach(data.forecast.forecastday, id: \.date) { day in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(day.date)
                                .foregroundColor(.white.opacity(0.8))

                            HStack {
                                Label("\(day.day.maxtemp_c, specifier: "%.0f")°", systemImage: "thermometer.sun.fill")
                                Spacer()
                                Label("\(day.day.mintemp_c, specifier: "%.0f")°", systemImage: "thermometer.snowflake")
                            }
                            .foregroundColor(.white)
                        }
                        Divider().background(.white.opacity(0.2))
                    }
                }
            }

        case .failure(let error):
            glassCard {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                    Text("Error: \(error.localizedDescription)")
                }
                .foregroundColor(.white)
            }
        }
    }
}
