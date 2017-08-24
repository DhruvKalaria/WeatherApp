//
//  ViewController.swift
//  WeatherApp
//
//  Created by Dhruv Kalaria on 8/22/17.
//  Copyright © 2017 Dhruv Kalaria. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var weather: WeatherAppModel!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getCurrentLocation()
    }
    
    
    func updateUI() {
        dateLabel.text = weather.date
        currentTempLabel.text = "\(weather.currentTemp)°"
        locationLabel.text = weather.city
        currentWeatherTypeLabel.text = weather.weatherType
        currentWeatherImage.image = UIImage(named: weather.weatherType)
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        //Downloading forecast weather data for TableView
        let currentURL = URL(string: APPURL.FORECAST_URL)!
        print(currentURL)
        Alamofire.request(currentURL).responseJSON { response in
            let result = response.result
            if let data = result.value as? Dictionary<String, AnyObject> {
                if let list = data["list"] as? [Dictionary<String,AnyObject>] {
                    for item in list {
                        let forecast = Forecast(data: item)
                        self.forecasts.append(forecast)
                    }
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func getCurrentLocation() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            if let currentLocation = locationManager.location {
                Location.sharedinstance.latitude = currentLocation.coordinate.latitude
                Location.sharedinstance.longiture = currentLocation.coordinate.longitude
                weather = WeatherAppModel()
                weather.downloadData {
                    self.downloadForecastData {
                        self.updateUI()
                    }
                }
            } else {
                locationManager.requestWhenInUseAuthorization()
                getCurrentLocation()
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            getCurrentLocation()
        }
    }
}

extension WeatherVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            cell.initalizeCell(forecast: self.forecasts[indexPath.row])
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecasts.count
    }
}
