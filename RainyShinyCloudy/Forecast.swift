//
//  Forecast.swift
//  RainyShinyCloudy
//
//  Created by Vitor Ferraz on 20/01/17.
//  Copyright © 2017 Vitor Ferraz. All rights reserved.
//

import UIKit
import Alamofire

class Forecast{
    var _date:String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp:String!
    
    var date:String{
        if _date == nil{
            _date = ""
        }
        return _date
    }
    
    var weatherType:String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp:String{
        if _highTemp == nil{
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp:String{
        if _lowTemp == nil{
            _lowTemp = ""
        }
        return _lowTemp
    }
 
    
    init(weatherDict: Dictionary<String,Any>) {
        if let temp = weatherDict["temp"] as? Dictionary<String,Any>{
            if let min = temp["min"] as?  Double{
                
                var kelvinToCelcius = min - 273.15
                kelvinToCelcius = (kelvinToCelcius * 100).rounded() / 100

                self._lowTemp = "\(kelvinToCelcius)"

            }
            
            if let max = temp["max"] as? Double{
                var kelvinToCelcius = max - 273.15
                 kelvinToCelcius = (kelvinToCelcius * 100).rounded() / 100
                self._highTemp = "\(kelvinToCelcius)"

            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String,Any>]{
            if let main = weather[0]["main"] as? String{
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double{
            let unixConverteDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConverteDate.dayOfTheWeek()
        }
        
    }
}




//extensions devem ser declaradas fora da classe
extension Date{
    func dayOfTheWeek() ->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" //nome completo do dia da semana
        return dateFormatter.string(from: self)
    }
}
