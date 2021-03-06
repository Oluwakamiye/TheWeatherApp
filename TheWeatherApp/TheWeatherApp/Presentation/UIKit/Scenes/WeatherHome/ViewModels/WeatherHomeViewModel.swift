//
//  WeatherDetailViewModel.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 20/06/2022.
//
import Foundation

protocol WeatherHomeViewModelDelegate: BaseViewModelDelegate {
    func reloadCollectionView()
    func updateCollectionView(shouldShowCollectionView: Bool)
}

final class WeatherHomeViewModel: NSObject {
    weak var delegate: WeatherHomeViewModelDelegate?
    private(set) var cities = [City]()
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateAddedCities),
                                               name: SharedAppData.updatedAddedCitiesNotification,
                                               object: nil)
    }
    
    @objc private func updateAddedCities() {
        cities = SharedAppData.shared.addedCities.map({$0.toDomain()})
        guard let delegate = delegate else {
            return
        }
        delegate.reloadCollectionView()
        delegate.updateCollectionView(shouldShowCollectionView: cities.count > 0)
    }
    
    func fetchCities() {
        guard let delegate = delegate else {
            return
        }
        cities = SharedAppData.shared.addedCities.map({$0.toDomain()})
        delegate.reloadCollectionView()
        delegate.updateCollectionView(shouldShowCollectionView: cities.count > 0)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: SharedAppData.updatedAddedCitiesNotification,
                                                  object: nil)
    }
}
