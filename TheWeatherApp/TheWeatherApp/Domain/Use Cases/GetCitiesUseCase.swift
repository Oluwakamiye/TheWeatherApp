//
//  GetCitiesUseCase.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/07/2022.
//

import Foundation

protocol GetCitiesUseCaseProtocol {
    func execute(_ cityName: String) async -> Result<[City], Error>
}

struct GetCitiesUseCase: GetCitiesUseCaseProtocol {
    var repo: CityRepositoryProtocol
    
    func execute(_ cityName: String) async -> Result<[City], Error> {
        do {
            let cities = try await repo.searchCity(cityName: cityName)
            return .success(cities)
        } catch(let error) {
            return .failure(error)
        }
    }
}
