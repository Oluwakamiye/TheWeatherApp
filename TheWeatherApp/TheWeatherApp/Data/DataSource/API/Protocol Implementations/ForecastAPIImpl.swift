//
//  ForecastAPIImpl.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/07/2022.
//

import Foundation

enum APIImplError: Error {
    case invalidType
}

struct ForecastAPIImpl: ForecastDataSource {
    func get1DayForecast(cityKey: String) async throws -> Forecast {
        return try await withCheckedThrowingContinuation({
            (continuation: CheckedContinuation<Forecast, Error>) in
            do {
                try? NetworkingService().get(url: "\(URLConstants.get1DayForecast.rawValue)\(cityKey)",
                                             parameters: [:],
                                             completion: { (result: Result<ForecastResponseDTO, Error>) in
                    switch result {
                    case .success(let returnedForecastResponse):
                        continuation.resume(returning: returnedForecastResponse.toDomain())
                    case .failure(let returnedError):
                        continuation.resume(throwing: returnedError)
                    }
                })
            }
        })
    }
    
    func get5DayForecast(cityKey: String) async throws -> Forecast {
        return try await withCheckedThrowingContinuation({
            (continuation: CheckedContinuation<Forecast, Error>) in
            do {
                try? NetworkingService().get(url: "\(URLConstants.get5DayForecast.rawValue)\(cityKey)",
                                             parameters: [:],
                                             completion: { (result: Result<ForecastResponseDTO, Error>) in
                    switch result {
                    case .success(let returnedForecastResponse):
                        continuation.resume(returning: returnedForecastResponse.toDomain())
                    case .failure(let returnedError):
                        continuation.resume(throwing: returnedError)
                    }
                })
            }
        })
    }
}
