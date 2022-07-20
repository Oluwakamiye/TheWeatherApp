//
//  CityResponseDTO+Response.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/07/2022.
//

import Foundation

// MARK: - City
struct CityResponseDTO: Codable {
    let version: Int
    let key: String
    let type: String
    let rank: Int
    let localizedName: String
    let englishName: String
    let primaryPostalCode: String
    let region: RegionDTO
    let country: CountryDTO
    let timeZone: TimeZoneDTO
    let geoPosition: GeoPositionDTO
    
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
extension CityResponseDTO {
    func toDomain() -> City {
        return City(version: version, key: key, type: type,
                    rank: rank, localizedName: localizedName,
                    englishName: englishName, primaryPostalCode: primaryPostalCode,
                    region: region.toDomain(), country: country.toDomain(),
                    timeZone: timeZone.toDomain(), geoPosition: geoPosition.toDomain())
    }
}

// MARK: - Region
extension CityResponseDTO {
    struct RegionDTO: Codable {
        let ID: String
        let localizedName: String
        let englishName: String
        
        enum CodingKeys: String, CodingKey {
            case ID = "ID"
            case localizedName = "LocalizedName"
            case englishName  = "EnglishName"
        }
    }
}
extension CityResponseDTO.RegionDTO {
    func toDomain() -> City.Region {
        return City.Region(ID: ID, localizedName: localizedName, englishName: englishName)
    }
}

// MARK: - Country
extension CityResponseDTO {
    struct CountryDTO: Codable {
        let ID: String
        let localizedName: String
        let englishName: String
        
        enum CodingKeys: String, CodingKey {
            case ID = "ID"
            case localizedName = "LocalizedName"
            case englishName  = "EnglishName"
        }
    }
}
extension CityResponseDTO.CountryDTO {
    func toDomain() -> City.Country {
        return City.Country(ID: ID, localizedName: localizedName, englishName: englishName)
    }
}

// MARK: - Timezone
extension CityResponseDTO {
    struct TimeZoneDTO: Codable {
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
}
extension CityResponseDTO.TimeZoneDTO {
    func toDomain() -> City.TimeZone {
        return City.TimeZone(code: code, name: name, gmtOffset: gmtOffset, isDaylightSaving: isDaylightSaving)
    }
}

// MARK: - GeoPosition
extension CityResponseDTO {
    struct GeoPositionDTO: Codable {
        let latitude: Float
        let longitude: Double
        let elevation: ElevationDTO
        
        enum CodingKeys: String, CodingKey {
            case latitude = "Latitude"
            case longitude = "Longitude"
            case elevation = "Elevation"
        }
    }
}
extension CityResponseDTO.GeoPositionDTO {
    func toDomain() -> City.GeoPosition {
        return City.GeoPosition(latitude: latitude, longitude: longitude, elevation: elevation.toDomain())
    }
}

// MARK: - Elevation
extension CityResponseDTO {
    struct ElevationDTO: Codable {
        let metric: ElevationTypeDTO
        let imperial: ElevationTypeDTO
        
        enum CodingKeys: String, CodingKey {
            case metric = "Metric"
            case imperial = "Imperial"
        }
    }
}
extension CityResponseDTO.ElevationDTO {
    func toDomain() -> City.Elevation {
        return City.Elevation(metric: metric.toDomain(), imperial: imperial.toDomain())
    }
}


// MARK: - MinMaxTemperature
extension CityResponseDTO {
    struct ElevationTypeDTO: Codable {
        let value: Double
        let unit: String
        let unitType: Int
        
        enum CodingKeys: String, CodingKey {
            case value = "Value"
            case unit = "Unit"
            case unitType = "UnitType"
        }
    }
}
extension CityResponseDTO.ElevationTypeDTO {
    func toDomain() -> City.ElevationType {
        return City.ElevationType(value: value, unit: unit, unitType: unitType)
    }
}
