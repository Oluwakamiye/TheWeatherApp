//
//  WeatherViewModel.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/06/2022.
//
import Foundation
import UIKit

protocol SavedWeatherCitiesViewModelDelegate: AnyObject {
    func updateTable()
    func navigateToCityDetailViewController(city: City)
}

final class SavedWeatherCitiesViewModel: NSObject {
    weak var delegate: SavedWeatherCitiesViewModelDelegate?
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
        guard let delegate = delegate else {
            return
        }
        displayedCities = cities
        delegate.updateTable()
    }
    
    func fetchCities() {
        guard let delegate = delegate else {
            return
        }
        cities = SharedAppData.shared.addedCities
        displayedCities = cities
        delegate.updateTable()
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
    
    func savedCitySelected(city: City) {
        guard let delegate = delegate else {
            return
        }
        delegate.navigateToCityDetailViewController(city: city)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: SharedAppData.updatedAddedCitiesNotification,
                                                  object: nil)
    }
}
