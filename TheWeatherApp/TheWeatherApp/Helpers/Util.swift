//
//  Util.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 20/06/2022.
//

import Foundation

func getPresentTime(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:m a"
    return dateFormatter.string(from: date)
}
