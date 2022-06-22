//
//  CityModels.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/06/2022.
//

import Foundation


// MARK: - City
struct City: Codable {
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
    
    enum CodingKeys: String, CodingKey {
        case version = "Version"
        case key = "Key"
        case type = "Type"
        case rank = "Rank"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
        case primaryPostalCode = "PrimaryPostalCode"
        case region = "Region"
        case country = "Country"
        case timeZone = "TimeZone"
        case geoPosition = "GeoPosition"
    }
}

// MARK: - Region
struct Region: Codable {
    let ID: String
    let localizedName: String
    let englishName: String
    
    enum CodingKeys: String, CodingKey {
        case ID = "ID"
        case localizedName = "LocalizedName"
        case englishName  = "EnglishName"
    }
}

// MARK: - Country
struct Country: Codable {
    let ID: String
    let localizedName: String
    let englishName: String
    
    enum CodingKeys: String, CodingKey {
        case ID = "ID"
        case localizedName = "LocalizedName"
        case englishName  = "EnglishName"
    }
}

// MARK: - Timezone
struct TimeZone: Codable {
    let code: String
    let name: String
    let gmtOffset: Float
    let isDaylightSaving: Bool
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case name = "Name"
        case gmtOffset = "GmtOffset"
        case isDaylightSaving = "IsDaylightSaving"
    }
    
}

// MARK: - GeoPosition
struct GeoPosition: Codable {
    let latitude: Float
    let longitude: Double
    let elevation: Elevation

    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case elevation = "Elevation"
    }
}

// MARK: - Elevation
struct Elevation: Codable {
    let metric: ElevationType
    let imperial: ElevationType

    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }
}

// MARK: - MinMaxTemperature
struct ElevationType: Codable {
    let value: Double
    let unit: String
    let unitType: Int
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}
