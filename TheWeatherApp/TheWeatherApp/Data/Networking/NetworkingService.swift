//
//  NetworkingService.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/07/2022.
//

import Foundation
import Alamofire

typealias URLRequestParameters = [String: Any]

struct NetworkingService {
    private var baseURL: String!// = "https://dataservice.accuweather.com/"
    private var weatherAPIKey: String!
    private var basicRequestParameters: URLRequestParameters!
    
    init() throws {
        guard let pList = Bundle.main.infoDictionary else {
            throw APIServiceError.missingPList
        }
        guard let baseURL = pList[InfoDictionaryKey.baseURL.rawValue] as? String else {
            throw APIServiceError.missingBaseURL
        }
        guard let weatherAPIKey = pList[InfoDictionaryKey.weatherAPIKey.rawValue] as? String else {
            throw APIServiceError.missingAPIKey
        }
        self.baseURL = baseURL
        self.weatherAPIKey = weatherAPIKey
        self.basicRequestParameters = [
            URLRequestParameterHeader.apikey.rawValue: weatherAPIKey,
            URLRequestParameterHeader.language.rawValue: "en-gb"
        ]
    }
    
    func get<T:Decodable>(url: String,
                          parameters: URLRequestParameters,
                          completion: @escaping (Result<T, Error>) -> Void) throws {
        let fullURLString = baseURL + url
        guard URL(string: fullURLString) != nil else {
            throw APIServiceError.badURL
        }
        guard let basicRequestParameters = basicRequestParameters else {
            throw APIServiceError.missingHeaders
        }
        var callParameters = basicRequestParameters
        for parameter in parameters {
            callParameters[parameter.key] = parameter.value
        }
        _ =  AF.request(fullURLString, method: .get, parameters: callParameters)
            .validate()
            .responseDecodable(of: T.self) {(response) in
                if let error = response.error {
                    completion(.failure(error))
                } else if let responseValue = response.value {
                    completion(.success(responseValue))
                }
            }
    }
}

enum URLRequestParameterHeader: String {
    case apikey
    case language
    case offset
    case alias
    case q
    case details
    case metric
    case toplevel
}
