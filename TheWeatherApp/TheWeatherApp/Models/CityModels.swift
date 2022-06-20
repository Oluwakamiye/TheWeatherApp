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
    let region: Region
    let country: Country
    
    enum CodingKeys: String, CodingKey {
        case version = "Version"
        case key = "Key"
        case type = "Type"
        case rank = "Rank"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
        case region = "Region"
        case country = "Country"
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
