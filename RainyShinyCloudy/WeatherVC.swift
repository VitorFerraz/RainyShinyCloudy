//
//  WatherVC.swift
//  RainyShinyCloudy
//
//  Created by Vitor Ferraz on 17/01/17.
//  Copyright © 2017 Vitor Ferraz. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation


class WatherVC: UIViewController , UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate{

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    var currentWeather: CurrentWeather!
    var foreCast : Forecast!
    
    var forecasts = [Forecast]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //melhor localizacao
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges() //mantem track changes no gps
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
      //  print(CURRENT_WEATHER_URL)
       
       currentWeather = CurrentWeather()


    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAutenticationStatus()
    }
    
    func locationAutenticationStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location //pega a localizacao
            Location.sharedInstance.latitude  = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
           // print("Location: \(Location.sharedInstance.longitude),\(Location.sharedInstance.latitude)")
            
            
            currentWeather.downloadWeatherDetails {
                //code to update table ui
                self.downloadForecastData{
                    self.updateMainUI()
                }
            }
        }else{
            locationManager.requestWhenInUseAuthorization()
            locationAutenticationStatus()
        }
    }
    
    
    func downloadForecastData(completed :@escaping DownloadComplete){
//        let forecastURL = URL(string: FORECAST_URL)
        Alamofire.request(FORECAST_URL).responseJSON{ response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,Any>{
                if let list = dict["list"] as? [Dictionary<String,Any>]{
                    
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                        
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
            
        }
    }
    
    //delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 //uma section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell{
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        }else{
            return WeatherCell()
        }
    }
    
    func updateMainUI(){
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)°C"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)

        
    }
    


}

