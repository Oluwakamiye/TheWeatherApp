//
//  CurrentConditionsRepository.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/07/2022.
//

import Foundation

protocol CurrentConditionsRepositoryProtocol {
    func getCurrentConditionsForCity(cityKey: String) async throws -> [CurrentConditions]
}
