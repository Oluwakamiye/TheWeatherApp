//
//  Storyboardable.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 17/07/2022.
//

import UIKit

protocol Storyboardable {
    static func create() -> Self
}

extension Storyboardable where Self: UIViewController {
    static func create() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
