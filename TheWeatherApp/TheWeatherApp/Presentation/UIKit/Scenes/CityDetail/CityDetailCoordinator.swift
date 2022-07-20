//
//  CityDetailCoordinator.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/07/2022.
//

import UIKit

protocol CityDetailFlow {
    func dismissDetail()
}

final class CityDetailCoordinator: Coordinator, CityDetailFlow {
    let navigationController: UINavigationController
    let city: City
    
    init(navigationController: UINavigationController, city: City) {
        self.navigationController = navigationController
        self.city = city
    }
    
    func start() {
        let cityDetailViewController = CityDetailViewController.makeSelf(city: city, coordinator: self)
        navigationController.present(cityDetailViewController, animated: true)
    }
    
    func dismissDetail() {
        navigationController.dismiss(animated: true)
    }
}
