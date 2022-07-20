//
//  GetForecastUseCase.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/07/2022.
//

import Foundation

protocol GetForecastsUseCaseProtocol {
    func get1DayForecast(cityKey: String) async -> Result<Forecast, Error>
    func get5DayForecast(cityKey: String) async -> Result<Forecast, Error>
}

struct GetForecastsUseCase: GetForecastsUseCaseProtocol {
    var repo: ForecastRepositoryProtocol
    
    func get1DayForecast(cityKey: String) async -> Result<Forecast, Error> {
        do {
            let forecast = try await repo.get1DayForecastForCity(cityKey: cityKey)
            return .success(forecast)
        } catch(let error) {
            return .failure(error)
        }
    }
    
    func get5DayForecast(cityKey: String) async -> Result<Forecast, Error> {
        do {
            let forecast = try await repo.get5DayForecastForCity(cityKey: cityKey)
            return .success(forecast)
        } catch(let error) {
            return .failure(error)
        }
    }
}
