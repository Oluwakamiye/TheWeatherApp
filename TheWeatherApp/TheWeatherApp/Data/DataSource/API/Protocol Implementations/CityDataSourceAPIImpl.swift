//
//  CityAPIImpl.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/07/2022.
//

import Foundation

struct CityDataSourceAPIImpl: CityDataSource {
    func getCities(cityName: String) async throws -> [City] {
        return try await withCheckedThrowingContinuation({
            (continuation: CheckedContinuation<[City], Error>) in
            do {
                try? NetworkingService().get(url: URLConstants.citySearch.rawValue,
                                             parameters: [
                                                URLRequestParameterHeader.q.rawValue: cityName
                                             ],
                                             completion: { (result: Result<[CityResponseDTO], Error>) in
                    switch result {
                    case .success(let returnedCities):
                        continuation.resume(returning: returnedCities.map({ $0.toDomain() }))
                    case .failure(let returnedError):
                        continuation.resume(throwing: returnedError)
                    }
                })
            }
        })
    }
}
