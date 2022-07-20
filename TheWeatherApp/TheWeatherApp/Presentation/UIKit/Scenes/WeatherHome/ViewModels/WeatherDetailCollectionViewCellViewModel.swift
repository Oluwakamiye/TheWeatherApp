//
//  WeatherDetailCollectionViewCellViewModel.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 08/07/2022.
//

import Foundation

protocol WeatherDetailCollectionViewCellViewModelDelegate: BaseViewModelDelegate {
    func setupViewsWithCity(city: City)
    func setupViewsWithCurrentConditions(currentConditionsResponse: CurrentConditions)
    func setupViewsWithDailyForecast(dailyForecast: Forecast.DailyForecast)
    func reloadTableView()
}

final class WeatherDetailCollectionViewCellViewModel: NSObject {
    weak var delegate: WeatherDetailCollectionViewCellViewModelDelegate?
    private var city: City
    private(set) var forecast: Forecast! {
        didSet {
            guard forecast != nil,
                  let delegate = delegate else {
                return
            }
            delegate.reloadTableView()
        }
    }
    private var currentConditionsResponse: CurrentConditions!
    
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
extension WeatherDetailCollectionViewCellViewModel {
    func fetchCurrentConditionsForCity() async {
        guard delegate != nil else {
            return
        }
        let usecase = GetCurrentConditionsUseCase(repo: CurrentConditionsRepositoryImpl(dataSource: CurrentConditionsAPIImpl()))
        handleReturnedWeatherCondition(result: await usecase.execute(cityKey: city.key))
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
        self.currentConditionsResponse = currentCondition
        delegate.setupViewsWithCurrentConditions(currentConditionsResponse: currentConditionsResponse)
    }
}

// MARK: - Multithreaded API call to get currentCity Temperature range
extension WeatherDetailCollectionViewCellViewModel {
    func fetchTemperatureRangeForCity() async {
        guard delegate != nil else {
            return
        }
        let usecase = GetForecastsUseCase(repo: ForecastRepositoryImpl(dataSource: ForecastAPIImpl()))
        handleReturnedForecast(result: await usecase.get5DayForecast(cityKey: city.key))
    }
    
    private func handleReturnedForecast(result: Result<Forecast, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let dayForecastResponse):
                self.setupDayForecastResponse(forecast: dayForecastResponse)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func setupDayForecastResponse(forecast: Forecast) {
        self.forecast = forecast
        guard let dayForecast = forecast.dailyForecasts.first,
              let delegate = delegate else {
            return
        }
        delegate.setupViewsWithDailyForecast(dailyForecast: dayForecast)
    }
}
