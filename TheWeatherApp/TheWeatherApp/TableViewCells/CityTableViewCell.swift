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
    @IBOutlet private(set) weak var actionImage: UIImageView!
    @IBOutlet private(set) weak var actionText: UILabel!
    
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
        updateActionViews()
    }
    
    private func updateActionViews() {
        let isCityAdded: Bool = sharedAppData.addedCities.contains(where: { $0.key == city.key})
        actionImage.image = UIImage(systemName: isCityAdded ? "plus": "checkmark")
        actionText.text = isCityAdded ? "remove" : "add"
    }
    
    @IBAction func addOrRemoveCity(_ sender: UIButton) {
        let isCityAdded: Bool = sharedAppData.addedCities.contains(where: { $0.key == city.key})
        if isCityAdded {
            sharedAppData.removeCity(city: city)
        } else {
            sharedAppData.addNewCity(city: city)
        }
        updateActionViews()
    }
}
