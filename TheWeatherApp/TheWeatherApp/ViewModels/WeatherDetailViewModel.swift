//
//  WeatherDetailViewModel.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 20/06/2022.
//

import Foundation

protocol WeatherDetailViewModelDelegate: BaseViewModelDelegate {
    func reloadCollectionView()
}

final class WeatherDetailViewModel: NSObject {
    weak var delegate: WeatherDetailViewModelDelegate?
    private(set) var cities = [City]()
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateAddedCities),
                                               name: SharedAppData.updatedAddedCitiesNotification,
                                               object: nil)
    }
    
    @objc private func updateAddedCities() {
        cities = SharedAppData.shared.addedCities
        guard let delegate = delegate else {
            return
        }
        delegate.reloadCollectionView()
    }
    
    func fetchCities() {
        guard let delegate = delegate else {
            return
        }
        cities = SharedAppData.shared.addedCities
        delegate.reloadCollectionView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: SharedAppData.updatedAddedCitiesNotification,
                                                  object: nil)
    }
}
