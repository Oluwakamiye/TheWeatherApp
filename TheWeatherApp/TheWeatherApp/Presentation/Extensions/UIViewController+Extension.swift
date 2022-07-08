//
//  UIViewController+Extension.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 20/06/2022.
//

import UIKit

extension UIViewController {
    static var className: String {
        return String(describing: self)
    }
}
