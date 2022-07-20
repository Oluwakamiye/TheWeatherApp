//
//  StandardUserDefaultsHelper.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 21/06/2022.
//

import Foundation

final class StandardUserDefaultsHelper {
    private static let standard = UserDefaults.standard
    
    enum StandardName: String {
        case cities = "Cities"
    }

    // Retrieves cities from userdefaults
    static func getCities() -> [CityResponseDTO]? {
        if let decoded = standard.object(forKey: StandardName.cities.rawValue) as? Data,
           let decodedCities = try? JSONDecoder().decode([CityResponseDTO].self, from: decoded) {
            return decodedCities
        } else {
            return nil
        }
    }
    
    // Saves cities to userdefaults
    static func setCities(cities: [CityResponseDTO]) {
        do {
            let citiesData = try JSONEncoder().encode(cities)
            standard.set(citiesData, forKey: StandardName.cities.rawValue)
        } catch {
            print("Couldn't save list of cities")
        }
    }
}
