//
//  WeatherTableViewCellViewModel.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 08/07/2022.
//

import Foundation

protocol WeatherTableViewCellViewModelDelegate: BaseViewModelDelegate {
    func setupViewsWithCity(city: City)
    func setupViewsWithCurrentConditions(currentConditionsResponse: CurrentConditionsResponse)
    func setupViewsWithDailyForecast(dailyForecast: DailyForecast)
}

final class WeatherTableViewCellViewModel: NSObject {
    weak var delegate: WeatherTableViewCellViewModelDelegate?
    private var city: City
    private(set) var forecastResponse: ForecastResponse!
    private var currentConditionsResponse: CurrentConditionsResponse!
    
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
    func fetchCurrentConditionsForCity() {
        guard delegate != nil else {
            return
        }
        NetworkingService().get(url: "\(URLConstants.getCurrentConditions.rawValue)\(city.key)",
                                parameters: [:],
                                completion: { [unowned self] (result) in
            DispatchQueue.main.async {
                self.handleReturnedWeatherCondition(result: result)
            }
        })
    }
    
    private func handleReturnedWeatherCondition(result: Result<[CurrentConditionsResponse], Error>) {
        switch result {
        case .success(let currentConditions):
            setupCurrentCondition(currentConditions: currentConditions)
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func setupCurrentCondition(currentConditions: [CurrentConditionsResponse]) {
        guard let currentCondition = currentConditions.first,
              let delegate = delegate else {
            return
        }
        self.currentConditionsResponse = currentCondition
        delegate.setupViewsWithCurrentConditions(currentConditionsResponse: currentConditionsResponse)
    }
}

// MARK: - Multithreaded API call to get currentCity Temperature range
extension WeatherTableViewCellViewModel {
    func fetchTemperatureRangeForCity() {
        guard delegate != nil else {
            return
        }
        NetworkingService().get(url: "\(URLConstants.get5DayForecast.rawValue)\(city.key)",
                                parameters: [:],
                                completion: { [unowned self] (result) in
            DispatchQueue.main.async {
                self.handleReturnedForecast(result: result)
            }
        })
    }
    
    private func handleReturnedForecast(result: Result<ForecastResponse, Error>) {
        switch result {
        case .success(let dayForecastResponse):
            setupDayForecastResponse(forecastResponse: dayForecastResponse)
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func setupDayForecastResponse(forecastResponse: ForecastResponse) {
        self.forecastResponse = forecastResponse
        guard let dayForecastResponse = forecastResponse.dailyForecasts.first,
              let delegate = delegate else {
            return
        }
        delegate.setupViewsWithDailyForecast(dailyForecast: dayForecastResponse)
    }
}
