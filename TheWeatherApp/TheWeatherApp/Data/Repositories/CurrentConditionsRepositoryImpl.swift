//
//  CurrentConditionsRepositoryImpl.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/07/2022.
//

import Foundation

struct CurrentConditionsRepositoryImpl: CurrentConditionsRepositoryProtocol {
    var dataSource: CurrentConditionsDataSource
    
    func getCurrentConditionsForCity(cityKey: String) async throws -> [CurrentConditions] {
        let currentConditions = try await dataSource.getCurrentConditions(cityKey: cityKey)
        return currentConditions
    }
}
