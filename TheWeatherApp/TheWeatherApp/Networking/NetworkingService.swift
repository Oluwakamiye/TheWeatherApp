//
//  NetworkingService.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/06/2022.
//

import Foundation
import Alamofire

typealias URLRequestParameters = [String: Any]

final class NetworkingService {
    static var shared = NetworkingService()
    private var baseURL: String!
    private var weatherAPIKey: String!
    private var basicRequestParameters: URLRequestParameters!
    
    private init() {
        guard let pList = Bundle.main.infoDictionary,
              let weatherAPIKey = pList[InfoListKeys.weatherAPIKey.rawValue] as? String,
              let baseURL = pList[InfoListKeys.baseURL.rawValue] as? String else {
            return
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
                          completion: @escaping (Result<T, Error>) -> Void) {
        guard let baseURL = baseURL,
              let basicRequestParameters = basicRequestParameters else {
            return
        }
        var callParameters = basicRequestParameters
        for parameter in parameters {
            callParameters[parameter.key] = parameter.value
        }
        _ = AF.request(baseURL + url, method: .get, parameters: callParameters)
            .validate()
            .responseDecodable(of: T.self) { (response) in
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
