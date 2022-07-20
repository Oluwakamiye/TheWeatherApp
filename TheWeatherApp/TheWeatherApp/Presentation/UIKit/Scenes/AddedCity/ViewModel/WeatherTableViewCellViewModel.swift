//
//  WeatherTableViewCellViewModel.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 08/07/2022.
//

import Foundation

protocol WeatherTableViewCellViewModelDelegate: BaseViewModelDelegate {
    func setupViewsWithCity(city: City)
    func setupViewsWithCurrentConditions(currentCondition: CurrentConditions)
    func setupViewsWithDailyForecast(dailyForecast: Forecast.DailyForecast)
}

final class WeatherTableViewCellViewModel: NSObject {
    weak var delegate: WeatherTableViewCellViewModelDelegate?
    private var city: City
    private(set) var forecast: Forecast!
    private var currentCondition: CurrentConditions!
    
    init(city: City) {
        self.city = city
    }
    
    func fetchCity() {
        guard let delegate = delegate else {
            return
        }
        delegate.setupViewsWithCity(city: city)
    }
}

// MARK: - Multithreaded API call to get currentCity Conditions
extension WeatherTableViewCellViewModel {
    func fetchCurrentConditionsForCity() async {
        guard delegate != nil else {
            return
        }
        let useCase = GetCurrentConditionsUseCase(repo: CurrentConditionsRepositoryImpl(dataSource: CurrentConditionsAPIImpl()))
        handleReturnedWeatherCondition(result: await useCase.execute(cityKey: city.key))
    }
    
    private func handleReturnedWeatherCondition(result: Result<[CurrentConditions], Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let currentConditions):
                self.setupCurrentCondition(currentConditions: currentConditions)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func setupCurrentCondition(currentConditions: [CurrentConditions]) {
        guard let currentCondition = currentConditions.first,
              let delegate = delegate else {
            return
        }
        self.currentCondition = currentCondition
        delegate.setupViewsWithCurrentConditions(currentCondition: currentCondition)
    }
}

// MARK: - Multithreaded API call to get currentCity Temperature range
extension WeatherTableViewCellViewModel {
    func fetchTemperatureRangeForCity() async {
        guard delegate != nil else {
            return
        }
        let useCase = GetForecastsUseCase(repo: ForecastRepositoryImpl(dataSource: ForecastAPIImpl()))
        handleReturnedForecast(result: await useCase.get5DayForecast(cityKey: city.key))
    }
    
    private func handleReturnedForecast(result: Result<Forecast, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let dayForecast):
                self.setupDayForecastResponse(forecast: dayForecast)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func setupDayForecastResponse(forecast: Forecast) {
        self.forecast = forecast
        guard let dailyForecast = forecast.dailyForecasts.first,
              let delegate = delegate else {
            return
        }
        delegate.setupViewsWithDailyForecast(dailyForecast: dailyForecast)
    }
}
