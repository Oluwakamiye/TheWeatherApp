//
//  ForecastRepositoryImpl.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/07/2022.
//

import Foundation

struct ForecastRepositoryImpl: ForecastRepositoryProtocol {
    var dataSource: ForecastDataSource
    
    func get1DayForecastForCity(cityKey: String) async throws -> Forecast {
        let forecastResponse = try await dataSource.get1DayForecast(cityKey: cityKey)
        return forecastResponse
    }
    
    func get5DayForecastForCity(cityKey: String) async throws -> Forecast {
        let forecastResponse = try await dataSource.get5DayForecast(cityKey: cityKey)
        return forecastResponse
    }
}
