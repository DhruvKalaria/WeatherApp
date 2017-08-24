//
//  Forecast.swift
//  rainyshinycloudy
//
//  Created by Caleb Stultz on 7/27/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(data: Dictionary<String,AnyObject>) {
        if let weather = data["weather"] as? [Dictionary<String,AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
                print(self._weatherType)
            }
        }
        
        if let temp = data["main"] as? Dictionary<String,AnyObject> {
            if let max = temp["temp_max"] as? Double {
                let kelvinToFarenheitPreDiv = (max * (9/5) - 459.67)
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDiv/10))
                self._highTemp = "\(kelvinToFarenheit)"
                print(self._highTemp)
            }
            
            if let min = temp["temp_min"] as? Double {
                let kelvinToFarenheitPreDiv = (min * (9/5) - 459.67)
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDiv/10))
                self._lowTemp = "\(kelvinToFarenheit)"
                print(self._lowTemp)
            }
        }
        
        if let dt = data["dt"] as? Double {
            let date = Date(timeIntervalSince1970: dt)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.short //Set date style
            let localDate = dateFormatter.string(from: date)
            self._date = localDate
        }
    }
    
}











