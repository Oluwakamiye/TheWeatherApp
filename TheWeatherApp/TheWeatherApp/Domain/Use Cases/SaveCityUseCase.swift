//
//  SaveCityUseCase.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/07/2022.
//

import Foundation

protocol SaveCityUseCaseProtocol {
    func execute(_ city: City) async -> Result<Bool, Error>
}

struct SaveCityUseCase {
//    @discardableResult
//    func execute(_ city: City) async -> Result<Bool, Error> {
//
//    }
}
