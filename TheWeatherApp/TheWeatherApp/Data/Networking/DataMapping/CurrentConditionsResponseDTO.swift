//
//  CurrentConditionsDTO.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/07/2022.
//

import Foundation


// MARK: - CurrentConditionsResponse
struct CurrentConditionsDTO: Codable {
    let localObservationDateTime: String
    let epochTime: Int
    let weatherText: String
    let weatherIcon: Int
    let hasPrecipitation: Bool
    let isDayTime: Bool
    let temperature: CurrentTemperatureDTO
    let mobileLink: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case localObservationDateTime = "LocalObservationDateTime"
        case epochTime = "EpochTime"
        case weatherText = "WeatherText"
        case weatherIcon = "WeatherIcon"
        case hasPrecipitation = "HasPrecipitation"
        case isDayTime = "IsDayTime"
        case temperature = "Temperature"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}
extension CurrentConditionsDTO {
    func toDomain() -> CurrentConditions {
        CurrentConditions(localObservationDateTime: localObservationDateTime,
                          epochTime: epochTime, weatherText: weatherText,
                          weatherIcon: weatherIcon, hasPrecipitation: hasPrecipitation,
                          isDayTime: isDayTime, temperature: temperature.toDomain(),
                          mobileLink: mobileLink, link: link)
    }
}

// MARK: - CurrentTemperature
extension CurrentConditionsDTO {
    struct CurrentTemperatureDTO: Codable {
        let metric: ForecastResponseDTO.TemperatureTypeDTO
        let imperial: ForecastResponseDTO.TemperatureTypeDTO
        
        enum CodingKeys: String, CodingKey {
            case metric = "Metric"
            case imperial = "Imperial"
        }
    }
}
extension CurrentConditionsDTO.CurrentTemperatureDTO {
    func toDomain() -> CurrentConditions.CurrentTemperature {
        CurrentConditions.CurrentTemperature(metric: metric.toDomain(), imperial: imperial.toDomain())
    }
}
