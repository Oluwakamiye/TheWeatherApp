//
//  SearchCityCoordinator.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/07/2022.
//

import UIKit

protocol SearchCityFlow {
    func coordinateToCityDetail(city: City)
    func dismiss()
}

final class SearchCityCoordinator: Coordinator, SearchCityFlow {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SearchCityViewModel(getCitiesUseCase: GetCitiesUseCase(repo: CityRepositoryImpl(dataSource: CityDataSourceAPIImpl())))
        let searchCityViewController = SearchCityViewController.makeSelf(coordinator: self, viewModel: viewModel)
        navigationController?.pushViewController(searchCityViewController, animated: true)
    }
    
    func coordinateToCityDetail(city: City) {
        guard let navigationController = navigationController else {
            return
        }
        let cityDetailCoordinator = CityDetailCoordinator(navigationController: navigationController, city: city)
        coordinate(to: cityDetailCoordinator)
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
}
