//
//  WeatherTableViewCell.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/06/2022.
//

import UIKit

final class WeatherTableViewCell: UITableViewCell {
    @IBOutlet private(set) weak var containingView: UIView!
    @IBOutlet private(set) weak var locationLabel: UILabel!
    @IBOutlet private(set) weak var timeLabel: UILabel!
    @IBOutlet private(set) weak var descriptionLabel: UILabel!
    @IBOutlet private(set) weak var temperatureLabel: UILabel!
    @IBOutlet private(set) weak var secondaryTemperatureLabel: UILabel!
    
    private var viewModel: WeatherTableViewCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(city: City) async {
        viewModel = WeatherTableViewCellViewModel(city: city)
        viewModel.delegate = self
        containingView.layer.cornerRadius = 10
        viewModel.fetchCity()
        await viewModel.fetchCurrentConditionsForCity()
        await viewModel.fetchTemperatureRangeForCity()
    }
}

// MARK: - ViewModel Delegates
extension WeatherTableViewCell: WeatherTableViewCellViewModelDelegate {
    func setupViewsWithCity(city: City) {
        containingView.layer.cornerRadius = 10
        locationLabel.text = city.englishName
        timeLabel.text = Date().getTimeIn12HourFormat()
    }
    
    func setupViewsWithCurrentConditions(currentCondition: CurrentConditions) {
        let dateFormatter = ISO8601DateFormatter()
        timeLabel.text = "\(dateFormatter.date(from: currentCondition.localObservationDateTime)!.getTimeIn12HourFormat())"
        descriptionLabel.text = currentCondition.weatherText
        temperatureLabel.text = "\(currentCondition.temperature.imperial.value)℉"
    }
    
    func setupViewsWithDailyForecast(dailyForecast: Forecast.DailyForecast) {
        secondaryTemperatureLabel.text = "H: \(Int(dailyForecast.temperature.maximum.value))° L: \(Int(dailyForecast.temperature.minimum.value))°"
    }
}
