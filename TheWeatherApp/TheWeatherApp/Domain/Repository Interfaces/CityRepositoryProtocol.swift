//
//  CityRepository.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/07/2022.
//

import Foundation

protocol CityRepositoryProtocol {
    func searchCity(cityName: String) async throws -> [City]
//    func saveCity(_ city: City) async -> Result<Bool, Error>
//    func removeCity(_ city: City) async -> Result<Bool, Error>
}
