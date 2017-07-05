//
//  Constants.swift
//  RainyShinyCloudy
//
//  Created by Vitor Ferraz on 17/01/17.
//  Copyright © 2017 Vitor Ferraz. All rights reserved.
//

import Foundation

//url example call http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=fafd7dcb9084d38b209b5386eaeafe29

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat=\(Location.sharedInstance.latitude!)"
let LONGITUDE = "&lon=\(Location.sharedInstance.longitude!)"
let APP_ID  = "&appid="
let API_KEY = "fafd7dcb9084d38b209b5386eaeafe29"


typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=fafd7dcb9084d38b209b5386eaeafe29"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=fafd7dcb9084d38b209b5386eaeafe29"
