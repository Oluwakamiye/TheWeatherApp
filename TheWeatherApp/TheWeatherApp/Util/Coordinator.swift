//
//  Coordinator.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/07/2022.
//

import Foundation

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
