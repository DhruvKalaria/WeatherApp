//
//  WeatherAppModel.swift
//  WeatherApp
//
//  Created by Dhruv Kalaria on 8/23/17.
//  Copyright © 2017 Dhruv Kalaria. All rights reserved.
//

import Foundation
import Alamofire

class WeatherAppModel {
    private var _city: String!
    private var _weatherType: String!
    private var _date: String!
    private var _currentTemp: Double!
    
    var city: String {
        get {
            if _city == nil {
                _city=""
            }
            return _city
        }
        set(newVal) {
            _city = newVal
        }
    }
    
    var weatherType: String {
        get {
            if _weatherType == nil {
                _weatherType = ""
            }
            return _weatherType
        }
        
        set(newVal) {
            _weatherType = newVal
        }
    }
    
    var currentTemp: Double {
        get {
            if _currentTemp == nil {
                _currentTemp = 0.0
            }
            return _currentTemp
        }
        set(newVal) {
            _currentTemp = newVal
        }
    }
    
    var date: String {
        
        get {
            if _date == nil {
                _date = ""
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            let today = dateFormatter.string(from: Date())
            _date = "Today, \(today)"
            return _date
        }
    }
    
    
    func downloadData(completion: @escaping DownloadComplete) {
        let currentURL = URL(string: APPURL.OPEN_WEATHER_URL)!
        print(currentURL)
        Alamofire.request(currentURL).responseJSON { response in
            let result = response.result
            if let weatherData = result.value as? Dictionary<String, AnyObject> {
                if let city = weatherData["name"] as? String {
                    self._city = city
                }
                
                if let w = weatherData["weather"]  as? [Dictionary<String,AnyObject>] {
                    if let main = w[0]["main"] as? String {
                        self._weatherType = main
                    }
                }
                
                if let main = weatherData["main"] as? Dictionary<String,AnyObject> {
                    if let temp = main["temp"] as? Double {
                        let kelvinToFarenheitPreDiv = (temp * (9/5) - 459.67)
                        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDiv/10))
                        self._currentTemp = kelvinToFarenheit
                    }
                }
            }
            completion()
        }
    }
}
