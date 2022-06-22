//
//  DailyForecastTableViewCell.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 22/06/2022.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {
    @IBOutlet private(set) weak var dayLabel: UILabel!
    @IBOutlet private(set) weak var dayForecastLabel: UILabel!
    @IBOutlet private(set) weak var nightForecastLabel: UILabel!
    @IBOutlet private(set) weak var highTempLabel: UILabel!
    @IBOutlet private(set) weak var lowTempLabel: UILabel!
    
    private var dailyForecast: DailyForecast!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(dailyForecast: DailyForecast) {
        self.dailyForecast = dailyForecast
        dayLabel.text = getDayForDate(dateString: dailyForecast.date)
        dayForecastLabel.text = "Day: \(dailyForecast.day.iconPhrase)"
        nightForecastLabel.text = "Night: \(dailyForecast.night.iconPhrase)"
        highTempLabel.text = "H: \(dailyForecast.temperature.maximum.value)°"
        lowTempLabel.text = "L: \(dailyForecast.temperature.minimum.value)°"
    }
    
    private func getDayForDate(dateString: String) -> String {
        let todaysDate = Date()
        let dateFormatter = ISO8601DateFormatter()
        guard let givenDateFromString = dateFormatter.date(from: dateString) else {
            return ""
        }
        let today = Calendar.current.dateComponents([.day], from: todaysDate)
        let givenDateDay = Calendar.current.dateComponents([.day], from: givenDateFromString)
        
        if today == givenDateDay {
            return "Today"
        } else {
            let dayDateFormatter = DateFormatter()
            dayDateFormatter.dateFormat = "E"
            return dayDateFormatter.string(from: givenDateFromString)
        }
    }
    
}
