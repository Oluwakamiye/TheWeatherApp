//
//  AppCoordinator.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/07/2022.
//

import UIKit

final class AppCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        // navigate to weather view controller
        let weatherHomeCoordinator = WeatherHomeCoordinator(navigationController: navigationController)
        coordinate(to: weatherHomeCoordinator)
    }
}
