//
//  DataBaseControllerTests.swift
//  WeatherApp
//
//  Created by Carlos Pages on 07/05/2017.
//  Copyright © 2017 cpages. All rights reserved.
//

import XCTest
@testable import WeatherApp

class DataBaseControllerTests: XCTestCase {
    
    let CITY_NAME = "City Test"
    let CITY_ID:Int64 = 123
    let CITY_TEMPERATURE_MAX:Float = 188.54
    let CITY_TEMPERATURE_MIN:Float = 154.34
    let CITY_WEATHER_DESCRIPTION = "This is a test weather description"
    
    var dataBaseController:DataBaseController!
    override func setUp() {
        super.setUp()
        self.dataBaseController = DataBaseController.init(memoryType:true, completionClosure: {
            
        })
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func _checkDataBaseIsEmptyOfCities () {
     
        do {
            let listOfCities = try self.dataBaseController.listOfCities()
            guard listOfCities.count == 0 else {
                XCTFail("The database is not empty")
                return
            }
        } catch _ {
            XCTFail("Error in db")
        }
    }
    
    func _cityTest(city:City){
        
        XCTAssert(city.name == self.CITY_NAME , "The city name doesn't match")
        XCTAssert(city.id == self.CITY_ID , "The city id doesn't match")
        XCTAssert(city.temperatureMax  ==  self.CITY_TEMPERATURE_MAX , "The city id doesn't match")
        XCTAssert(city.temperatureMin == self.CITY_TEMPERATURE_MIN , "The city id doesn't match")
        XCTAssert(city.weatherDescription == self.CITY_WEATHER_DESCRIPTION , "The city id doesn't match")
    }

    func testInserCityAndListCities () {
        
        self._checkDataBaseIsEmptyOfCities()
        
        do {
            let _ = try self.dataBaseController.persistCity(cityName: CITY_NAME, cityID: CITY_ID, temperatureMax: CITY_TEMPERATURE_MAX, temperatureMin: CITY_TEMPERATURE_MIN, weatherDescription: CITY_WEATHER_DESCRIPTION)
            
            let newListOfCities = try self.dataBaseController.listOfCities()
            guard newListOfCities.count == 1, let city = newListOfCities.first else {
                XCTFail("The database doesn't have the city")
                return
            }
            
            self._cityTest(city: city)
            
        } catch _ {
            XCTFail("Error in db")
        }
    }
    
    func testRemoveAllCities () {
        
        self._checkDataBaseIsEmptyOfCities()

        do {
            let _ = try self.dataBaseController.persistCity(cityName: CITY_NAME, cityID: CITY_ID, temperatureMax: CITY_TEMPERATURE_MAX, temperatureMin: CITY_TEMPERATURE_MIN, weatherDescription: CITY_WEATHER_DESCRIPTION)
            
            try self.dataBaseController.removeAllCities()
            
            self._checkDataBaseIsEmptyOfCities()
            
        } catch _ {
            XCTFail("Error in db")
        }
    }
}
