//
//  CurrentConditionsAPIImpl.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/07/2022.
//

import Foundation

struct CurrentConditionsAPIImpl: CurrentConditionsDataSource {
    func getCurrentConditions(cityKey: String) async throws -> [CurrentConditions] {
        return try await withCheckedThrowingContinuation({
            (continuation: CheckedContinuation<[CurrentConditions], Error>) in
            do {
                try? NetworkingService().get(url: "\(URLConstants.getCurrentConditions.rawValue)\(cityKey)",
                                             parameters: [:],
                                             completion: { (result: Result<[CurrentConditionsDTO], Error>) in
                    switch result {
                    case .success(let returnedCurrentConditionsResponse):
                        continuation.resume(returning: returnedCurrentConditionsResponse.map({$0.toDomain()}))
                    case .failure(let returnedError):
                        continuation.resume(throwing: returnedError)
                    }
                })
            }
        })
    }
}
