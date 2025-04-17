//
//  CurrentWeather.swift
//  wetherApp
//
//  Created by Aisha Suanbekova Bakytjankyzy on 11.04.2025.
//

import Foundation

struct CurrentWeatherResponse: Decodable {
    let current: CurrentWeather
    let location: Location
}

struct CurrentWeather: Decodable {
    let last_updated: String
    let temp_c: Double
    let cloud: Int
    let wind_kph: Double
    let condition: Condition
}

struct Condition: Decodable {
    let text: String
    let icon: String
}

struct Location: Decodable {
    let name: String
    let country: String
    let localtime: String
}
