//
//  WeatherHomeCoordinator.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/07/2022.
//

import UIKit

protocol WeatherHomeFlow: AnyObject {
    func coordinateToSearchCity()
    func coordinateToAddedCities()
}

final class WeatherHomeCoordinator: WeatherHomeFlow, Coordinator {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    init(navigationController: UINavigationController, didFinish: () -> Void) {
        self.navigationController = navigationController
    }
    
    func start() {
        let weatherHomeViewController = WeatherHomeViewController.makeSelf(coordinator: self)
        navigationController?.pushViewController(weatherHomeViewController, animated: false)
    }
    
    func coordinateToSearchCity() {
        guard let navigationController = navigationController else {
            return
        }
        let searchCityCoordinator = SearchCityCoordinator(navigationController: navigationController)
        coordinate(to: searchCityCoordinator)
    }
    
    func coordinateToAddedCities() {
        guard let navigationController = navigationController else {
            return
        }
        let addedCityCoordinator = AddedCityCoordinator(navigationController: navigationController)
        coordinate(to: addedCityCoordinator)
    }
}
