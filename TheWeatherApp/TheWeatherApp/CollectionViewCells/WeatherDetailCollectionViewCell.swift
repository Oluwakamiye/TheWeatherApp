//
//  WeatherDetailCollectionViewCell.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 20/06/2022.
//

import UIKit

class WeatherDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet private(set) weak var cityNameLabel: UILabel!
    @IBOutlet private(set) weak var temperatureLabel: UILabel!
    @IBOutlet private(set) weak var weatherLabel: UILabel!
    @IBOutlet private(set) weak var temperatureRangeLabel: UILabel!
    @IBOutlet private(set) weak var forecastTableView: UITableView!
    
    private var city: City!
    private var forecastResponse: ForecastResponse! {
        didSet {
            guard forecastResponse != nil else {
                return
            }
            forecastTableView.reloadData()
        }
    }
    private var currentConditionsResponse: CurrentConditionsResponse!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        forecastTableView.register(UINib(nibName: String(describing: DailyForecastTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: DailyForecastTableViewCell.self))
    }

    func configureCell(city: City) {
        self.city = city
        cityNameLabel.text = city.englishName
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.fetchCurrentConditionsForCity()
            self?.fetchTemperatureRangeForCity()
        }
    }
}

// MARK: - Network calls
extension  WeatherDetailCollectionViewCell {
    // Multithreaded API call to get currentCity Conditions
    @objc private func fetchCurrentConditionsForCity() {
        NetworkingService().get(url: "\(URLConstants.getCurrentConditions.rawValue)\(city.key)",
                                     parameters: [:],
                                     completion: { [weak self] (result) in
            DispatchQueue.main.async {
                self?.handleReturnedCondition(result: result)
            }
        })
    }
    
    private func handleReturnedCondition(result: Result<[CurrentConditionsResponse], Error>) {
        switch result {
        case .success(let currentConditions):
            setupCurrentCondition(currentConditions: currentConditions)
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func setupCurrentCondition(currentConditions: [CurrentConditionsResponse]) {
        guard let currentCondition = currentConditions.first else {
            return
        }
        self.currentConditionsResponse = currentCondition
        weatherLabel.text = currentCondition.weatherText
        temperatureLabel.text = "\(currentCondition.temperature.imperial.value)℉"
    }
    
    // Multithreaded API call to get currentCity Temperature range
    @objc private func fetchTemperatureRangeForCity() {
        NetworkingService().get(url: "\(URLConstants.get5DayForecast.rawValue)\(city.key)",
                                     parameters: [:],
                                     completion: { [weak self] (result) in
            DispatchQueue.main.async {
                self?.handleReturnedForecast(result: result)
            }
        })
    }
    
    private func handleReturnedForecast(result: Result<ForecastResponse, Error>) {
        switch result {
        case .success(let dayForecastResponse):
            setupDayForecastResponse(forecastResponse: dayForecastResponse)
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func setupDayForecastResponse(forecastResponse: ForecastResponse) {
        self.forecastResponse = forecastResponse
        guard let dayForecastResponse = forecastResponse.dailyForecasts.first else {
            return
        }
        temperatureRangeLabel.text = "H: \(Int(dayForecastResponse.temperature.maximum.value))° L: \(Int(dayForecastResponse.temperature.minimum.value))°"
    }
}

// MARK: - TableView Delegates
extension WeatherDetailCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let forecastResponse = forecastResponse else {
            return 0
        }
        return forecastResponse.dailyForecasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let forecastResponse = forecastResponse,
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyForecastTableViewCell.self), for: indexPath) as? DailyForecastTableViewCell else {
            return UITableViewCell()
        }
        let dailyForecast = forecastResponse.dailyForecasts[indexPath.row]
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
