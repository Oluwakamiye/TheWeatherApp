//
//  WeatherDetailViewModel.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 20/06/2022.
//

import Foundation

protocol WeatherDetailViewModelDelegate: BaseViewModelDelegate {
    func setupCityLabel(weatherInformation: NSAttributedString)
    func setupDailyForecast(forecasts: [DailyForecast])
}

final class WeatherDetailViewModel: NSObject {
    weak var delegate: WeatherDetailViewModelDelegate?
    private var forecast: ForecastResponse!
    private var cityName: String!
    
    func setValues(cityName: String, weatherForecast: ForecastResponse) {
        self.cityName = cityName
        self.forecast = weatherForecast
    }
    
    func getWeatherValues() {
        guard let delegate = delegate else {
            return
        }
//        delegate.setupCityLabel(weatherInformation: <#T##NSAttributedString#>)
        delegate.setupDailyForecast(forecasts: forecast.dailyForecasts)
    }
    
    private func generateAttributedString() {
        
    }
}
