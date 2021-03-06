//
//  WeatherDetailCollectionViewCell.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 20/06/2022.
//

import UIKit

final class WeatherDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet private(set) weak var cityNameLabel: UILabel!
    @IBOutlet private(set) weak var temperatureLabel: UILabel!
    @IBOutlet private(set) weak var weatherLabel: UILabel!
    @IBOutlet private(set) weak var temperatureRangeLabel: UILabel!
    @IBOutlet private(set) weak var forecastTableView: UITableView!
    
    private var viewModel: WeatherDetailCollectionViewCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        forecastTableView.register(UINib(nibName: String(describing: DailyForecastTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: DailyForecastTableViewCell.self))
    }

    func configureCell(city: City) async {
        viewModel = WeatherDetailCollectionViewCellViewModel(city: city)
        viewModel.delegate = self
        viewModel.fetchCity()
        await viewModel.fetchCurrentConditionsForCity()
        await viewModel.fetchTemperatureRangeForCity()
    }
}

// MARK: - TableView Delegates
extension WeatherDetailCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let forecast = viewModel?.forecast else {
            return 0
        }
        return forecast.dailyForecasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let forecast = viewModel.forecast,
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyForecastTableViewCell.self), for: indexPath) as? DailyForecastTableViewCell else {
            return UITableViewCell()
        }
        let dailyForecast = forecast.dailyForecasts[indexPath.row]
        cell.configureCell(dailyForecast: dailyForecast)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "5-Day Forecast"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}

// MARK: - ViewModel Delegates
extension WeatherDetailCollectionViewCell: WeatherDetailCollectionViewCellViewModelDelegate {
    func setupViewsWithCity(city: City) {
        cityNameLabel.text = city.englishName
    }
    
    func setupViewsWithCurrentConditions(currentConditionsResponse: CurrentConditions) {
        weatherLabel.text = currentConditionsResponse.weatherText
        temperatureLabel.text = "\(currentConditionsResponse.temperature.imperial.value)???"
    }
    
    func setupViewsWithDailyForecast(dailyForecast: Forecast.DailyForecast) {
        temperatureRangeLabel.text = "H: \(Int(dailyForecast.temperature.maximum.value))?? L: \(Int(dailyForecast.temperature.minimum.value))??"
    }
    
    func reloadTableView() {
        forecastTableView.reloadData()
    }
}
