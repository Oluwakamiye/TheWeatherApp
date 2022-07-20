//
//  CityModels.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 17/07/2022.
//

import Foundation

// MARK: - City
struct City {
    let version: Int
    let key: String
    let type: String
    let rank: Int
    let localizedName: String
    let englishName: String
    let primaryPostalCode: String
    let region: Region
    let country: Country
    let timeZone: TimeZone
    let geoPosition: GeoPosition
}

// MARK: - Region
extension City {
    struct Region {
        let ID: String
        let localizedName: String
        let englishName: String
    }
}

// MARK: - Country
extension City {
    struct Country {
        let ID: String
        let localizedName: String
        let englishName: String
    }
}

// MARK: - Timezone
extension City {
    struct TimeZone {
        let code: String
        let name: String
        let gmtOffset: Float
        let isDaylightSaving: Bool
    }
}

// MARK: - GeoPosition
extension City {
    struct GeoPosition {
        let latitude: Float
        let longitude: Double
        let elevation: Elevation
    }
}

// MARK: - Elevation
extension City {
    struct Elevation {
        let metric: ElevationType
        let imperial: ElevationType
    }
}

// MARK: - MinMaxTemperature
extension City {
    struct ElevationType {
        let value: Double
        let unit: String
        let unitType: Int
    }
}
