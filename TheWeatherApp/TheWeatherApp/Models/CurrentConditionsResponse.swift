//
//  CurrentConditionsResponse.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 20/06/2022.
//

import Foundation

// MARK: - CurrentConditionsResponse
struct CurrentConditionsResponse: Codable {
    let localObservationDateTime: Date
    let epochTime: Int
    let weatherText: String
    let weatherIcon: Int
    let hasPrecipitation: Bool
    let isDayTime: Bool
    let temperature: CurrentTemperature
    let mobileLink, link: String
    
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

// MARK: - CurrentTemperature
struct CurrentTemperature: Codable {
    let metric: TemperatureType
    let imperial: TemperatureType
    
    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }
}
