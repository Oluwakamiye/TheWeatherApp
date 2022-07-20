//
//  CityRepositoryImpl.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/07/2022.
//

import Foundation

struct CityRepositoryImpl: CityRepositoryProtocol {
    var dataSource: CityDataSource
    
    func searchCity(cityName: String) async throws -> [City] {
        let cities = try await dataSource.getCities(cityName: cityName)
        return cities
    }
    
//    func saveCity(_ city: City) async -> Result<Bool, Error> {
//
//    }
//
//    func removeCity(_ city: City) async -> Result<Bool, Error> {
//
//    }
}

