//
//  Storyboard+Extension.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/06/2022.
//

import UIKit

extension UIStoryboard {
    enum StoryboardName: String {
        case Main
    }
    
    static func storyboard(_ storyboardName: StoryboardName) -> UIStoryboard {
        return UIStoryboard(name: storyboardName.rawValue, bundle: nil)
    }
}
