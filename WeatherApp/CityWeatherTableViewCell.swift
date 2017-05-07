//
//  CityWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Carlos Pages on 07/05/2017.
//  Copyright © 2017 cpages. All rights reserved.
//

import UIKit

class CityWeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var temperatureMinLabel: UILabel!
    @IBOutlet weak var temperatureMaxLabel: UILabel!
    @IBOutlet weak var descriptionWeatherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellWith(city:City) {
        
        self.locationNameLabel.text = city.name
        self.temperatureMinLabel.text = String(city.temperatureMin)
        self.temperatureMaxLabel.text = String(city.temperatureMax)
        self.descriptionWeatherLabel.text = city.weatherDescription
    }

}
