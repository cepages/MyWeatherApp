//
//  CityMappable.swift
//  WeatherApp
//
//  Created by Carlos Pages on 06/05/2017.
//  Copyright © 2017 cpages. All rights reserved.
//
import Foundation
import ObjectMapper

/*!
 @class CityMappable
 
 @discussion This class represents a JSON City with weather
 */
struct CityMappable: Mappable {
    var cityName: String?
    var cityID: Int?
    var maxTemperature: Float?
    var minTemperature: Float?
    var weatherDescription: String?
    
    init?(map: Map) {
    
    }
    
    init(cityName:String?, cityID:Int?, maxTemperature:Float?, minTemperature:Float?, weatherDescription:String?) {
        
        self.cityName = cityName
        self.cityID = cityID
        self.maxTemperature = maxTemperature
        self.minTemperature = minTemperature
        self.weatherDescription = weatherDescription
    }
    
    mutating func mapping(map: Map) {
        cityName                <- map["name"]
        cityID                  <- map["id"]
        maxTemperature          <- map["main.temp_max"]
        minTemperature          <- map["main.temp_min"]
        weatherDescription      <- map["weather.0.description"]
    }
}

