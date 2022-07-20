//
//  ForecastRepository.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/07/2022.
//

import Foundation

protocol ForecastRepositoryProtocol {
    func get1DayForecastForCity(cityKey: String) async throws  -> Forecast
    func get5DayForecastForCity(cityKey: String) async throws  -> Forecast
}
