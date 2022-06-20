//
//  WeatherDetailViewController.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 20/06/2022.
//

import UIKit

final class WeatherDetailViewController: UIViewController {
    @IBOutlet private(set) weak var cityTemperatureLabel: UILabel!
    @IBOutlet private(set) weak var dailyForecastCollectionView: UICollectionView!
    
    private var viewModel = WeatherDetailViewModel()
    private var forecasts = [DailyForecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.delegate = self
//        dailyForecastCollectionView.delegate = self
//        dailyForecastCollectionView.dataSource = self
        
//        dailyForecastCollectionView.register(UINib(nibName: <#T##String#>, bundle: <#T##Bundle?#>), forCellWithReuseIdentifier: <#T##String#>)
    }
    
    static func makeSelf(cityName: String, weatherForecast: ForecastResponse) -> WeatherDetailViewController? {
        guard let destinationVC = UIStoryboard.storyboard(.Main).instantiateViewController(withIdentifier: WeatherDetailViewController.className) as? WeatherDetailViewController else {
            return nil
        }
        destinationVC.viewModel.setValues(cityName: cityName, weatherForecast: weatherForecast)
        return destinationVC
    }
}

// MARK: - CollectionView Delegate
//extension WeatherDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        forecasts.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//    }
//}

// MARK: - ViewModelDelegates
extension WeatherDetailViewController: WeatherDetailViewModelDelegate {
    func setupDailyForecast(forecasts: [DailyForecast]) {
        self.forecasts = forecasts
        dailyForecastCollectionView.reloadData()
    }
    
    func setupCityLabel(weatherInformation: NSAttributedString) {
        cityTemperatureLabel.attributedText = weatherInformation
    }
}
