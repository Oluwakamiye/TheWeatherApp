//
//  CurrentConditions.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 17/07/2022.
//

import Foundation

// MARK: - CurrentConditionsResponse
struct CurrentConditions {
    let localObservationDateTime: String
    let epochTime: Int
    let weatherText: String
    let weatherIcon: Int
    let hasPrecipitation: Bool
    let isDayTime: Bool
    let temperature: CurrentTemperature
    let mobileLink: String
    let link: String
}

// MARK: - CurrentTemperature
extension CurrentConditions {
    struct CurrentTemperature {
        let metric: Forecast.TemperatureType
        let imperial: Forecast.TemperatureType
    }
}
