//
//  GetCurrentConditionsUseCase.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/07/2022.
//

import Foundation

protocol GetCurrentConditionsUseCaseProtocol {
    func execute(cityKey: String) async -> Result<[CurrentConditions], Error>
}

struct GetCurrentConditionsUseCase: GetCurrentConditionsUseCaseProtocol {
    var repo: CurrentConditionsRepositoryProtocol
    
    func execute(cityKey: String) async -> Result<[CurrentConditions], Error> {
        do {
            let conditions = try await repo.getCurrentConditionsForCity(cityKey: cityKey)
            return .success(conditions)
        } catch(let error) {
            return .failure(error)
        }
    }
}
