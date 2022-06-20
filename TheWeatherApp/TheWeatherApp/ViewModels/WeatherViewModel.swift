//
//  WeatherViewModel.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/06/2022.
//

import Foundation


protocol WeatherViewModelDelegate: AnyObject {
    func updateTable()
}

final class WeatherViewModel: NSObject {
    weak var delegate: WeatherViewModelDelegate?
    private var cities = [City]()
    private(set) var displayedCities = [City]()
    private let notificationKey = ""
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateAddedCities),
                                               name: SharedAppData.updatedAddedCitiesNotification,
                                               object: nil)
    }
    
    @objc private func updateAddedCities() {
        cities = SharedAppData.shared.addedCities
    }
    
    func searchCity(cityName: String? = nil) {
        guard let delegate = delegate else {
            return
        }
        if let cityName = cityName,
           !cityName.isEmpty {
            displayedCities = cities.filter { $0.englishName.lowercased().contains(cityName.lowercased()) }
            delegate.updateTable()
        } else {
            displayedCities = cities
            delegate.updateTable()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: SharedAppData.updatedAddedCitiesNotification,
                                                  object: nil)
    }
}
