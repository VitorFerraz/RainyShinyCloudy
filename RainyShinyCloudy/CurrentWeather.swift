//
//  CurrentWeather.swift
//  RainyShinyCloudy
//
//  Created by Vitor Ferraz on 17/01/17.
//  Copyright © 2017 Vitor Ferraz. All rights reserved.
//

import UIKit

import Alamofire

class CurrentWeather{
    var _cityName :String!
    var _date :String!
    var _weatherType:String!
    var _currentTemp:Int!
    
    var cityName:String{
        if _cityName == nil{
            _cityName = ""
        }
        return _cityName
    }
    
    var date:String{
        if _date == nil{
            _date = ""
        }
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium //“Tuesday, April 12, 1952 AD” or “3:30:42 PM Pacific Standard Time”.
        dateFormater.timeStyle = .none //sem horario
        
        let currentDate = dateFormater.string(from: Date()) //transforma em string
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType:String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp:Int{
        if _currentTemp == nil{
            _currentTemp = 0
        }
        return _currentTemp
    }
    
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        //Alamofire fownload
        
       // let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)
            Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
               let result  = response.result
                print("resultado \(result.value)")
                if let dict = result.value as? Dictionary<String,Any>{
                    if let name = dict["name"] as? String {
                        if name == "Vila Gopoúva" {
                            self._cityName = "Guarulhos"
                        }else{
                            self._cityName = name.capitalized
                        }
                        
                        print(self._cityName)
                    }
                    
                    if let weather = dict["weather"] as? [Dictionary<String,Any>]{
                        //primeiro objeto do array
                        if let main = weather[0]["main"] as? String {
                            self._weatherType = main.capitalized
                            print(self._weatherType)
                        }
                    }
                    
                    if let main = dict["main"] as? Dictionary<String,Any>{
                        if let currentTemperature = main["temp"] as? Double{
                            let kelvinToCelcius = currentTemperature - 273.15
                            
                            self._currentTemp = Int(kelvinToCelcius.rounded())
                            
                            print(self._currentTemp)
                            
                        }
                    }
                }
               completed() // fim do request
            }
        }
}
