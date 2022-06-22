//
//  ForecastModels.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/06/2022.
//

import Foundation

// MARK: - ForecastResponse
struct ForecastResponse: Codable {
    let headline: Headline
    let dailyForecasts: [DailyForecast]

    enum CodingKeys: String, CodingKey {
        case headline = "Headline"
        case dailyForecasts = "DailyForecasts"
    }
}

// MARK: - Headline
struct Headline: Codable {
    let effectiveDate: String
    let effectiveEpochDate: Int
    let severity: Int
    let text: String
    let category: String
//    let endDate: String?
//    let endEpochDate: Int?
    let mobileLink: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case effectiveDate = "EffectiveDate"
        case effectiveEpochDate = "EffectiveEpochDate"
        case severity = "Severity"
        case text = "Text"
        case category = "Category"
//        case endDate = "EndDate"
//        case endEpochDate = "EndEpochDate"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}


// MARK: - DailyForecast
struct DailyForecast: Codable {
    let date: String
    let epochDate: Int
    let temperature: Temperature
    let day: Day
    let night: Day

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case epochDate = "EpochDate"
        case temperature = "Temperature"
        case day = "Day"
        case night = "Night"
    }
}

// MARK: - Day
struct Day: Codable {
    let icon: Int
    let iconPhrase: String
    let hasPrecipitation: Bool
    let precipitationType: String?
    let precipitationIntensity: String?

    enum CodingKeys: String, CodingKey {
        case icon = "Icon"
        case iconPhrase = "IconPhrase"
        case hasPrecipitation = "HasPrecipitation"
        case precipitationType = "PrecipitationType"
        case precipitationIntensity = "PrecipitationIntensity"
    }
}

// MARK: - Temperature
struct Temperature: Codable {
    let minimum, maximum: TemperatureType

    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}

// MARK: - MinMaxTemperature
struct TemperatureType: Codable {
    let value: Double
    let unit: String
    let unitType: Int
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}
