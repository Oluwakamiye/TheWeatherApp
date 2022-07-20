//
//  CityDataSource.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/07/2022.
//

import Foundation

protocol CityDataSource {
    func getCities(cityName: String) async throws -> [City]
}
