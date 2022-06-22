//
//  TheWeatherAppApiTests.swift
//  TheWeatherAppTests
//
//  Created by Oluwakamiye Akindele on 22/06/2022.
//

import XCTest

class TheWeatherAppApiTests: XCTestCase {
    private var sut: NetworkingService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NetworkingService()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    // MARK: - Get 1 Day API
    // Test the get1DayForecast API
    func testGet1DayForecastAPI() {
        // given
        let cityKey = "297442"
        let urlString = "\(URLConstants.get1DayForecast.rawValue)\(cityKey)"
        let promise = expectation(description: "Forecast Response received")
        var error: Error?
        var forecastResponse: ForecastResponse?

        // when
        sut.get(url: urlString,
                parameters: [:],
                completion: {  (result: Result<ForecastResponse, Error>) in
            switch result {
            case .success(let forecastResponseFromResult):
                forecastResponse = forecastResponseFromResult
            case .failure(let errorFromResult):
                error = errorFromResult
            }
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        // then
        XCTAssertNil(error)
        XCTAssertNotNil(forecastResponse)
        XCTAssertEqual(forecastResponse?.dailyForecasts.count, 1, "Response should have one forecast")
    }
    
    // Test the get1DayForecast API Performance
    func testGet1DayForecastAPIPerformance() {
        measure(metrics: [
            XCTClockMetric(),
                  XCTCPUMetric(),
                  XCTStorageMetric(),
                  XCTMemoryMetric()
        ]) {
            testGet1DayForecastAPI()
        }
    }
    
    // MARK: - Get 5 Day API
    // Test the get5DayForecast API
    func testGet5DayForecastAPI() {
        // given
        let cityKey = "297442"
        let urlString = "\(URLConstants.get5DayForecast.rawValue)\(cityKey)"
        let promise = expectation(description: "Forecast Response received")
        var error: Error?
        var forecastResponse: ForecastResponse?

        // when
        sut.get(url: urlString,
                parameters: [:],
                completion: {  (result: Result<ForecastResponse, Error>) in
            switch result {
            case .success(let forecastResponseFromResult):
                forecastResponse = forecastResponseFromResult
            case .failure(let errorFromResult):
                error = errorFromResult
            }
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        // then
        XCTAssertNil(error)
        XCTAssertNotNil(forecastResponse)
        XCTAssertEqual(forecastResponse?.dailyForecasts.count, 5, "Response should have 5 forecasts")
    }
    
    // Test the get5DayForecast API Performance
    func testGet5DayForecastAPIPerformance() {
        measure(metrics: [
            XCTClockMetric(),
                  XCTCPUMetric(),
                  XCTStorageMetric(),
                  XCTMemoryMetric()
        ]) {
            testGet5DayForecastAPI()
        }
    }
    
    // MARK: - Get CurrentConditions API
    // Test the getCurrentConditions API
    func testGetCurrentConditionsAPI() {
        // given
        let cityKey = "297442"
        let urlString = "\(URLConstants.getCurrentConditions.rawValue)\(cityKey)"
        let promise = expectation(description: "CurrentConditions Response received")
        var error: Error?
        var currentConditionsResponse: [CurrentConditionsResponse]?

        // when
        sut.get(url: urlString,
                parameters: [:],
                completion: {  (result: Result<[CurrentConditionsResponse], Error>) in
            switch result {
            case .success(let currentConditionsResponseFromResult):
                currentConditionsResponse = currentConditionsResponseFromResult
            case .failure(let errorFromResult):
                error = errorFromResult
            }
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        // then
        XCTAssertNil(error)
        XCTAssertNotNil(currentConditionsResponse)
    }
    
    // Test the GetCurrentConditions API Performance
    func testGetCurrentConditionsPerformance() {
        measure(metrics: [
            XCTClockMetric(),
                  XCTCPUMetric(),
                  XCTStorageMetric(),
                  XCTMemoryMetric()
        ]) {
            testGetCurrentConditionsAPI()
        }
    }
    
    // MARK: - Get SearchCity API
    // Test the searchCity API
    func testSearchCityAPI() {
        // given
        let cityName = "london"
        let promise = expectation(description: "Forecast Response received")
        var error: Error?
        var cities: [City]?

        // when
        sut.get(url: URLConstants.citySearch.rawValue,
                parameters: [
                    URLRequestParameterHeader.q.rawValue: cityName
                             ],
                 completion: { (result: Result<[City], Error>) in
                    switch result {
                    case .success(let citiesFromResult):
                        cities = citiesFromResult
                    case .failure(let errorFromResult):
                        error = errorFromResult
                    }
                    promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        // then
        XCTAssertNil(error)
        XCTAssertNotNil(cities)
    }
    
    // Test the testSearchCityAPI API Performance
    func testSearchCityAPIPerformance() {
        measure(metrics: [
            XCTClockMetric(),
                  XCTCPUMetric(),
                  XCTStorageMetric(),
                  XCTMemoryMetric()
        ]) {
            testSearchCityAPI()
        }
    }
}
