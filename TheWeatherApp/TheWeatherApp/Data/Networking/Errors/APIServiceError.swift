//
//  APIServiceError.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/07/2022.
//

import Foundation

enum APIServiceError: Error {
    case missingAPIKey
    case badURL
    case statusNotOK
    case missingBaseURL
    case missingPList
    case missingHeaders
    case decodingError
}
