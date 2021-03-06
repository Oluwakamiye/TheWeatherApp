//
//  SearchCityViewModel.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/06/2022.
//

import Foundation

protocol SearchCityViewModelDelegate: BaseViewModelDelegate {
    func updateTable()
    func navigateToCityDetailView(city: City)
}

final class SearchCityViewModel: NSObject {
    weak var delegate: SearchCityViewModelDelegate?
    private(set) var cities: [City] = [City]()
    private let getCitiesUseCase: GetCitiesUseCaseProtocol
    
    init(getCitiesUseCase: GetCitiesUseCaseProtocol) {
        self.getCitiesUseCase = getCitiesUseCase
    }
    
    func searchForCity(cityName: String? = nil) async {
        guard let delegate = delegate,
              let cityName = cityName else {
            return
        }
        if cityName.isEmpty {
            cities = [City]()
            delegate.updateTable()
        } else {
            handleReturnedCities(delegate: delegate, result: await getCitiesUseCase.execute(cityName))
        }
    }
    
    private func handleReturnedCities(delegate: SearchCityViewModelDelegate, result: Result<[City], Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let cities):
                self.cities = cities
                delegate.updateTable()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func tableViewTapped(city: City) {
        guard let delegate = delegate else {
            return
        }
        delegate.navigateToCityDetailView(city: city)
    }
}
