//
//  SharedAppData.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 20/06/2022.
//

import Foundation

final class SharedAppData {
    static let shared = SharedAppData()
    static let updatedAddedCitiesNotification = Notification.Name("AddedCitiesUpdated")
    private(set) var addedCities: [CityResponseDTO] = [CityResponseDTO]() {
        didSet {
            NotificationCenter.default.post(name: SharedAppData.updatedAddedCitiesNotification, object: nil)
            StandardUserDefaultsHelper.setCities(cities: addedCities)
        }
    }
    
    private init() {
        addedCities = StandardUserDefaultsHelper.getCities() ?? [CityResponseDTO]()
    }
    
    func setAddedCities(addedCities: [CityResponseDTO]) {
        self.addedCities = addedCities
    }
    
    func addNewCity(city: CityResponseDTO) {
        self.addedCities.append(city)
    }
    
    func addNewCity(city: City) {
        let region = CityResponseDTO.RegionDTO(ID: city.region.ID,
                                               localizedName: city.region.localizedName,
                                               englishName: city.region.englishName)
        let country = CityResponseDTO.CountryDTO(ID: city.country.ID,
                                                 localizedName: city.country.localizedName,
                                                 englishName: city.country.englishName)
        let timeZone = CityResponseDTO.TimeZoneDTO(code: city.timeZone.code,
                                                   name: city.timeZone.name,
                                                   gmtOffset: city.timeZone.gmtOffset,
                                                   isDaylightSaving: city.timeZone.isDaylightSaving)
        let metric = CityResponseDTO.ElevationTypeDTO(value: city.geoPosition.elevation.metric.value,
                                                      unit: city.geoPosition.elevation.metric.unit,
                                                      unitType: city.geoPosition.elevation.metric.unitType)
        let imperial = CityResponseDTO.ElevationTypeDTO(value: city.geoPosition.elevation.imperial.value,
                                                        unit: city.geoPosition.elevation.imperial.unit,
                                                        unitType: city.geoPosition.elevation.imperial.unitType)
        let elevation = CityResponseDTO.ElevationDTO(metric: metric, imperial: imperial)
        let geoPosition = CityResponseDTO.GeoPositionDTO(latitude: city.geoPosition.latitude,
                                                         longitude: city.geoPosition.longitude,
                                                         elevation: elevation)
        let cityResponseDTO = CityResponseDTO(version: city.version,
                                              key: city.key,
                                              type: city.type,
                                              rank: city.rank,
                                              localizedName: city.localizedName,
                                              englishName: city.englishName,
                                              primaryPostalCode: city.primaryPostalCode,
                                              region: region,
                                              country: country,
                                              timeZone: timeZone,
                                              geoPosition: geoPosition)
        self.addedCities.append(cityResponseDTO)
    }
    
    func removeCity(at index: Int) {
        self.addedCities.remove(at: index)

    }
    
    func removeCity(city: City) {
        self.addedCities.removeAll(where: {$0.key == city.key})
    }
}
