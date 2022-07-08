//
//  SharedAppData.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 20/06/2022.
//

import Foundation

class SharedAppData {
    static let shared = SharedAppData()
    static let updatedAddedCitiesNotification = Notification.Name("AddedCitiesUpdated")
    private(set) var addedCities: [City] = [City]() {
        didSet {
            NotificationCenter.default.post(name: SharedAppData.updatedAddedCitiesNotification, object: nil)
            StandardUserDefaultsHelper.setCities(cities: addedCities)
        }
    }
    
    private init() {
        addedCities = StandardUserDefaultsHelper.getCities() ?? [City]()
    }
    
    func setAddedCities(addedCities: [City]) {
        self.addedCities = addedCities
    }
    
    func addNewCity(city: City) {
        self.addedCities.append(city)
    }
    
    func removeCity(at index: Int) {
        self.addedCities.remove(at: index)

    }
    
    func removeCity(city: City) {
        self.addedCities.removeAll(where: {$0.key == city.key})
    }
}
