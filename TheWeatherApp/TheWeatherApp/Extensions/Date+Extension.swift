//
//  Date+Extension.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 20/06/2022.
//

import Foundation

extension Date {
    func getTimeIn12HourFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:m a"
        return dateFormatter.string(from: self)
    }
}
