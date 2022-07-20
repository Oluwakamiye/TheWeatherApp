//
//  CurrentConditionsDataSource.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/07/2022.
//

import Foundation

protocol CurrentConditionsDataSource {
    func getCurrentConditions(cityKey: String) async throws -> [CurrentConditions]
}
