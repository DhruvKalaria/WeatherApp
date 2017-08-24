//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Dhruv Kalaria on 8/23/17.
//  Copyright © 2017 Dhruv Kalaria. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherTypeIcon: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    func initalizeCell(forecast: Forecast) {
        dateLabel.text = forecast.date
        weatherTypeLabel.text = forecast.weatherType
        highTempLabel.text = forecast.highTemp + "°"
        lowTempLabel.text = forecast.lowTemp + "°"
        weatherTypeIcon.image = UIImage(named: forecast.weatherType)
    }
}
