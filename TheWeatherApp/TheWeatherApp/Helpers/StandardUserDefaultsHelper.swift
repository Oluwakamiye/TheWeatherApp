//
//  StandardUserDefaultsHelper.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 21/06/2022.
//

import Foundation

final class StandardUserDefaults {
    private static let standard = UserDefaults.standard
    
    enum StandardName: String {
        case cities = "Cities"
    }

    // Removes cities to userdefaults
    static func getCities() -> [City]? {
        if let decoded = standard.object(forKey: StandardName.cities.rawValue) as? Data,
           let decodedSetting = try? JSONDecoder().decode([City].self, from: decoded) {
            return decodedSetting
        } else {
            return nil
        }
    }
    
    // Saves cities to userdefaults
    static func setCities(cities: [City]) {
        do {
            let citiesData = try JSONEncoder().encode(cities)
            standard.set(citiesData, forKey: StandardName.cities.rawValue)
        } catch {
            print("Couldn't save list of cities")
        }
    }
}
