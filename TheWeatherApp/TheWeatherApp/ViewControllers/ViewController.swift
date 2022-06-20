//
//  ViewController.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 18/06/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        guard let pList = Bundle.main.infoDictionary,
              let weatherAPIKey = pList[InfoListKeys.weatherAPIKey.rawValue] as? String,
              let baseURL = pList[InfoListKeys.baseURL.rawValue] as? String else {
            return
        }
        print("Weather API:: \(weatherAPIKey)")
        print("BASE URL:: \(baseURL)")
        doSth()
    }

    
    func doSth() {
        NetworkingService.shared.get(url: URLConstants.citySearch.rawValue,
                                     parameters: [
                                        URLRequestParameterHeader.q.rawValue: "london"
                                     ],
                                     completion: { [weak self] (result) in
            self?.completionHandler(result: result)
        })
    }
    

    private func completionHandler(result: Result<[City], Error>) {
        switch result {
        case .success(let cities):
            print("Cities count \(cities.count)")
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
}

