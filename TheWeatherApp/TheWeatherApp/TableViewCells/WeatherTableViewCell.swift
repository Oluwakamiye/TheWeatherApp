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
    private(set) var city: City!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(city: City) {
        self.city = city
        containingView.layer.cornerRadius = 10
        locationLabel.text = city.englishName
        timeLabel.text = Date().getTimeIn12HourFormat()
        performSelector(inBackground: #selector(fetchCurrentConditionsForCity), with: nil)
    }
    
    @objc private func fetchCurrentConditionsForCity() {
        NetworkingService.shared.get(url: "\(URLConstants.getCurrentConditions.rawValue)/\(city.key)",
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
        timeLabel.text = currentCondition.localObservationDateTime.getTimeIn12HourFormat()
        descriptionLabel.text = currentCondition.weatherText
        temperatureLabel.text = "\(currentCondition.temperature.imperial.value)℉"
        secondaryTemperatureLabel.text = "metric: \(currentCondition.temperature.metric.value)℃"
    }
}
