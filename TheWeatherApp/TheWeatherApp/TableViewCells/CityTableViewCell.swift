//
//  CityTableViewCell.swift
//  TheWeatherApp
//
//  Created by Oluwakamiye Akindele on 19/06/2022.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    @IBOutlet private(set) weak var containingView: UIView!
    @IBOutlet private(set) weak var cityLabel: UILabel!
    @IBOutlet private(set) weak var countryLabel: UILabel!
    @IBOutlet private(set) weak var postCodeLabel: UILabel!
    
    private var city: City!
    private let sharedAppData = SharedAppData.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(city: City) {
        self.city = city
        containingView.layer.cornerRadius = 10
        cityLabel.text = city.englishName
        countryLabel.text = city.country.englishName
        postCodeLabel.text = city.primaryPostalCode
    }
}
