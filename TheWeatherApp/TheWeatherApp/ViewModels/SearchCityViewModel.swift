//
//  SearchCityViewModel.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/06/2022.
//

import Foundation

protocol SearchCityViewModelDelegate: BaseViewModelDelegate {
    func updateTable()
}

final class SearchCityViewModel: NSObject {
    weak var delegate: SearchCityViewModelDelegate?
    private(set) var cities: [City] = [City]()
    
    func searchForCity(city: String? = nil) {
        guard let delegate = delegate,
            let city = city else {
            return
        }
        if city.isEmpty {
            cities = [City]()
            delegate.updateTable()
        } else {
            NetworkingService.shared.get(url: URLConstants.citySearch.rawValue,
                                         parameters: [
                                            URLRequestParameterHeader.q.rawValue: city
                                         ],
                                         completion: { [weak self] (result) in
                self?.handleReturnedCities(delegate: delegate, result: result)
            })
        }
    }
    
    private func handleReturnedCities(delegate: SearchCityViewModelDelegate, result: Result<[City], Error>) {
        switch result {
        case .success(let cities):
            self.cities = cities
            delegate.updateTable()
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
}
