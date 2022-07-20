//
//  ForecastResponseDTO.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/07/2022.
//

import Foundation

// MARK: - ForecastResponseDTO
struct ForecastResponseDTO: Codable {
    let headline: HeadlineDTO
    let dailyForecasts: [DailyForecastDTO]
    
    enum CodingKeys: String, CodingKey {
        case headline = "Headline"
        case dailyForecasts = "DailyForecasts"
    }
}
extension ForecastResponseDTO {
    func toDomain() -> Forecast {
        Forecast(headline: headline.toDomain(), dailyForecasts: dailyForecasts.map({ $0.toDomain()}))
    }
}

// MARK: - Headline
extension ForecastResponseDTO {
    struct HeadlineDTO: Codable {
        let effectiveDate: String
        let effectiveEpochDate: Int
        let severity: Int
        let text: String
        let category: String
        let mobileLink: String
        let link: String
        
        enum CodingKeys: String, CodingKey {
            case effectiveDate = "EffectiveDate"
            case effectiveEpochDate = "EffectiveEpochDate"
            case severity = "Severity"
            case text = "Text"
            case category = "Category"
            case mobileLink = "MobileLink"
            case link = "Link"
        }
    }
}
extension ForecastResponseDTO.HeadlineDTO {
    func toDomain() -> Forecast.Headline {
        Forecast.Headline(effectiveDate: effectiveDate,
                                  effectiveEpochDate: effectiveEpochDate,
                                  severity: severity, text: text,
                                  category: category,
                                  mobileLink: mobileLink,
                                  link: link)
    }
}

// MARK: - DailyForecast
extension ForecastResponseDTO {
    struct DailyForecastDTO: Codable {
        let date: String
        let epochDate: Int
        let temperature: TemperatureDTO
        let day: DayDTO
        let night: DayDTO
        
        enum CodingKeys: String, CodingKey {
            case date = "Date"
            case epochDate = "EpochDate"
            case temperature = "Temperature"
            case day = "Day"
            case night = "Night"
        }
    }
}
extension ForecastResponseDTO.DailyForecastDTO {
    func toDomain() -> Forecast.DailyForecast {
        Forecast.DailyForecast(date: date,
                                       epochDate: epochDate,
                                       temperature: temperature.toDomain(),
                                       day: day.toDomain(),
                                       night: night.toDomain())
    }
}

// MARK: - Day
extension ForecastResponseDTO {
    struct DayDTO: Codable {
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
}
extension ForecastResponseDTO.DayDTO {
    func toDomain() -> Forecast.Day {
        Forecast.Day(icon: icon, iconPhrase: iconPhrase,
                             hasPrecipitation: hasPrecipitation,
                             precipitationType: precipitationType,
                             precipitationIntensity: precipitationIntensity)
    }
}

// MARK: - Temperature
extension ForecastResponseDTO {
    struct TemperatureDTO: Codable {
        let minimum, maximum: TemperatureTypeDTO
        
        enum CodingKeys: String, CodingKey {
            case minimum = "Minimum"
            case maximum = "Maximum"
        }
    }
}
extension ForecastResponseDTO.TemperatureDTO {
    func toDomain() -> Forecast.Temperature {
        Forecast.Temperature(minimum: minimum.toDomain(), maximum: maximum.toDomain())
    }
}

// MARK: - MinMaxTemperature
extension ForecastResponseDTO {
    struct TemperatureTypeDTO: Codable {
        let value: Double
        let unit: String
        let unitType: Int
        
        enum CodingKeys: String, CodingKey {
            case value = "Value"
            case unit = "Unit"
            case unitType = "UnitType"
        }
    }
}
extension ForecastResponseDTO.TemperatureTypeDTO {
    func toDomain() -> Forecast.TemperatureType {
        Forecast.TemperatureType(value: value, unit: unit, unitType: unitType)
    }
}
