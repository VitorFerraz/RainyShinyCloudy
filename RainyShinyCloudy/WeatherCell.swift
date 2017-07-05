//
//  WeatherCell.swift
//  RainyShinyCloudy
//
//  Created by Vitor Ferraz on 20/01/17.
//  Copyright © 2017 Vitor Ferraz. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    
    
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    
    func configureCell(forecast : Forecast){
        //pega o dados de Forecast
        lowTemp.text = "\(forecast.lowTemp) °C"
        highTemp.text = "\(forecast.highTemp) °C"
        weatherType.text = forecast.weatherType
        
        dayLabel.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
        
    }

}
