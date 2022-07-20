//
//  RemoveCityUseCase.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/07/2022.
//

import Foundation

protocol RemoveCityUseCaseProtocol {
    func execute(_ city: City) async -> Result<Bool, Error>
}

struct RemoveCityUseCase {
//    @discardableResult
//    func execute(_ city: City) async -> Result<Bool, Error> {
//
//    }
}
