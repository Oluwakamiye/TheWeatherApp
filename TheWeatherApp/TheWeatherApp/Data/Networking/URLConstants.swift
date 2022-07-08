//
//  URLConstants.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/06/2022.
//

import Foundation

enum URLConstants: String {
    case get5DayForecast = "forecasts/v1/daily/5day/"
    case get1DayForecast = "forecasts/v1/daily/1day/"
    case citySearch = "locations/v1/cities/search"
    case geoPositionSearch = "locations/v1/cities/geoposition/search"
    case getCurrentConditions = "currentconditions/v1/"
}
