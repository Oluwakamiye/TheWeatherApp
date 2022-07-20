//
//  ForecastDataSource.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/07/2022.
//

import Foundation

protocol ForecastDataSource {
    func get1DayForecast(cityKey: String) async throws -> Forecast
    func get5DayForecast(cityKey: String) async throws -> Forecast
}
