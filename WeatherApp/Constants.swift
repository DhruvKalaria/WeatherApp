//
//  Constants.swift
//  WeatherApp
//
//  Created by Dhruv Kalaria on 8/23/17.
//  Copyright © 2017 Dhruv Kalaria. All rights reserved.
//

import Foundation

struct APPURL {
    struct Domains {
        static let BASE_URL = "http://api.openweathermap.org/data/2.5/"
        static var queryParams = ["lat": "\(Location.sharedinstance.latitude!)", "lon":"\(Location.sharedinstance.longiture!)", "appid":"<CUSTOM APP ID FROM OPEN WEATHER>"]
    }
    
    static let OPEN_WEATHER_URL = "\(Domains.BASE_URL)weather?lat=\(Domains.queryParams["lat"]!)&lon=\(Domains.queryParams["lon"]!)&appid=\(Domains.queryParams["appid"]!)"
    
    static let FORECAST_URL = "\(Domains.BASE_URL)forecast?lat=\(Domains.queryParams["lat"]!)&lon=\(Domains.queryParams["lon"]!)&APPID=\(Domains.queryParams["appid"]!)"
}

//TypeAliases
typealias DownloadComplete = () -> ()
