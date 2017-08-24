//
//  Location.swift
//  WeatherApp
//
//  Created by Dhruv Kalaria on 8/23/17.
//  Copyright © 2017 Dhruv Kalaria. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedinstance = Location()
    init() { }
    
    var latitude: Double!
    var longiture: Double!
}
