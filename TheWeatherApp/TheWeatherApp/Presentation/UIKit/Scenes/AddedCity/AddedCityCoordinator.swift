//
//  AddedCityCoordinator.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/07/2022.
//

import UIKit

protocol AddedCityFlow: Coordinator {
    func coordinateToCityDetail(city: City)
    func dismiss()
}

final class AddedCityCoordinator: AddedCityFlow {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let addedCityViewController = AddedCityViewController.makeSelf(coordinator: self)
        navigationController?.pushViewController(addedCityViewController, animated: true)
    }
    
    func coordinateToCityDetail(city: City) {
        guard let navigationController = navigationController else {
            return
        }
        let cityDetailCoordinator = CityDetailCoordinator(navigationController: navigationController, city: city)
        coordinate(to: cityDetailCoordinator)
    }
    
    func dismiss() {
        
    }
}
