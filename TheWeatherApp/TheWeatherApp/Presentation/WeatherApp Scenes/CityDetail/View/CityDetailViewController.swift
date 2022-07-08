//
//  CityDetailViewController.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 21/06/2022.
//

import UIKit

final class CityDetailViewController: UIViewController {
    @IBOutlet private(set) weak var cityNameLabel: UILabel!
    @IBOutlet private(set) weak var postcodeLabel: UILabel!
    @IBOutlet private(set) weak var countryNameLabel: UILabel!
    @IBOutlet private(set) weak var regionNameLabel: UILabel!
    @IBOutlet private(set) weak var timeZoneLabel: UILabel!
    @IBOutlet private(set) weak var positionLabel: UILabel!
    @IBOutlet private(set) weak var elevationLabel: UILabel!
    @IBOutlet private(set) weak var addRemoveButton: UIButton!
    private let sharedAppData = SharedAppData.shared
    private var city: City!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCityDetails()
        setupAddRemoveButton()
    }
    
    private func setupCityDetails() {
        guard let city = city else {
            return
        }
        cityNameLabel.text = city.englishName
        postcodeLabel.text = city.primaryPostalCode
        countryNameLabel.text = city.country.englishName
        regionNameLabel.text = city.region.englishName
        timeZoneLabel.text = city.timeZone.code + " \(city.timeZone.gmtOffset >= 0 ? "+" : "")"  + "\(city.timeZone.gmtOffset)"
        positionLabel.text = "lat:\(city.geoPosition.latitude) lon:\(city.geoPosition.longitude) "
        elevationLabel.text = "\(city.geoPosition.elevation.metric.value)\(city.geoPosition.elevation.metric.unit)"
    }
    
    private func setupAddRemoveButton() {
        guard let city = city else {
            return
        }
        let isCityAdded: Bool = sharedAppData.addedCities.contains(where: { $0.key == city.key})
        setupAddRemoveButtonTitle(isCityAdded: isCityAdded)
        addRemoveButton.layer.cornerRadius = 10
    }
    
    private func setupAddRemoveButtonTitle(isCityAdded: Bool) {
        addRemoveButton.setTitle("\(isCityAdded ? "Remove City" : "Add City" )", for: .normal)
    }
    
    @IBAction func addRemoveButtonTapped(_ sender: UIButton) {
        let isCityAdded: Bool = sharedAppData.addedCities.contains(where: { $0.key == city.key})
        if isCityAdded {
            sharedAppData.removeCity(city: city)
        } else {
            sharedAppData.addNewCity(city: city)
        }
        setupAddRemoveButtonTitle(isCityAdded: !isCityAdded)
    }
    
    static func makeSelf(city: City) -> CityDetailViewController? {
        guard let destinationVC = UIStoryboard.storyboard(.Main).instantiateViewController(withIdentifier: CityDetailViewController.className) as? CityDetailViewController else {
            return nil
        }
        destinationVC.city = city
        return destinationVC
    }
}
