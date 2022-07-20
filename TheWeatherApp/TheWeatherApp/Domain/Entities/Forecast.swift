//
//  Forecast.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 17/07/2022.
//

import Foundation

// MARK: - ForecastResponse
struct Forecast {
    let headline: Headline
    let dailyForecasts: [DailyForecast]
}

// MARK: - Headline
extension Forecast {
    struct Headline {
        let effectiveDate: String
        let effectiveEpochDate: Int
        let severity: Int
        let text: String
        let category: String
        let mobileLink: String
        let link: String
    }
}

// MARK: - DailyForecast
extension Forecast {
    struct DailyForecast {
        let date: String
        let epochDate: Int
        let temperature: Temperature
        let day: Day
        let night: Day
    }
}

// MARK: - Temperature
extension Forecast {
    struct Temperature {
        let minimum, maximum: TemperatureType
    }
}

// MARK: - MinMaxTemperature
extension Forecast {
    struct TemperatureType {
        let value: Double
        let unit: String
        let unitType: Int
    }
}

// MARK: - Day
extension Forecast {
    struct Day {
        let icon: Int
        let iconPhrase: String
        let hasPrecipitation: Bool
        let precipitationType: String?
        let precipitationIntensity: String?
    }
}
