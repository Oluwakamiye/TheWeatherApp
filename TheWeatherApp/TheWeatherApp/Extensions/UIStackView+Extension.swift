//
//  UIStackView+Extension.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/06/2022.
//

import UIKit

extension UIStackView {
    @IBInspectable var paddingVertical: CGFloat {
        get {
            return self.layoutMargins.top
        }
        set {
            self.isLayoutMarginsRelativeArrangement = true
            self.layoutMargins = UIEdgeInsets(top: newValue, left: self.layoutMargins.left, bottom: newValue, right: self.layoutMargins.right)
        }
    }
    
    @IBInspectable var paddingHorizontal: CGFloat {
        get {
            return self.layoutMargins.left
        }
        set {
            self.isLayoutMarginsRelativeArrangement = true
            self.layoutMargins = UIEdgeInsets(top: self.layoutMargins.top, left: newValue, bottom: self.layoutMargins.bottom, right: newValue)
        }
    }
    
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
