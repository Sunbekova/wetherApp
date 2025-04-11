//
//  AppSecrets.swift
//  wetherApp
//
//  Created by Aisha Suanbekova Bakytjankyzy on 11.04.2025.
//

import Foundation

enum AppSecrets {
    static var weatherAPIKey: String {
        guard
            let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let key = dict["WeatherAPIKey"] as? String
        else {
            fatalError("WeatherAPIKey not found in Keys.plist")
        }
        return key
    }
}
