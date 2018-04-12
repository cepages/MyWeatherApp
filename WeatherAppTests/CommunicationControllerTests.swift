//
//  CommunicationControllerTests.swift
//  WeatherApp
//
//  Created by Carlos Pages on 06/05/2017.
//  Copyright © 2017 cpages. All rights reserved.
//

import XCTest
@testable import WeatherApp
import OHHTTPStubs

class CommunicationControllerTests: XCTestCase {
    
    let communicationController = CommunicationsController()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }
    
    let MAX_TEMPERATURE:Float = 284.67
    let MIN_TEMPERTURE:Float = 262.45
    let WEATHER_DESCRIPTION = "Sky is Clear"
    let CITY_ID = 514297
    let CITY_NAME = "Ostafyevo"
    

    func cityTest(city:CityMappable){
        
        XCTAssert(city.cityName == self.CITY_NAME , "The city name doesn't match")
        XCTAssert(city.cityID == self.CITY_ID , "The city id doesn't match")
        XCTAssert( city.maxTemperature  ==  self.MAX_TEMPERATURE , "The city id doesn't match")
        XCTAssert(city.minTemperature == self.MIN_TEMPERTURE , "The city id doesn't match")
        XCTAssert(city.weatherDescription == self.WEATHER_DESCRIPTION , "The city id doesn't match")
    }

    func testCitiesInCycle() {
        
        let JSON_FORECAST = "{\"message\":\"accurate\",\"cod\":\"200\",\"count\":10,\"list\":[{\"id\":\(CITY_ID),\"name\":\"\(CITY_NAME)\",\"coord\":{\"lat\":55.4951,\"lon\":37.5033},\"main\":{\"temp\":262.65,\"pressure\":1030,\"humidity\":61,\"temp_min\":\(MIN_TEMPERTURE),\"temp_max\":\(MAX_TEMPERATURE)},\"dt\":1485790200,\"wind\":{\"speed\":4,\"deg\":220},\"sys\":{\"country\":\"\"},\"rain\":null,\"snow\":null,\"clouds\":{\"all\":0},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"\(WEATHER_DESCRIPTION)\",\"icon\":\"01n\"}]}]}"
    
        stub(condition: isHost(HOST)) { _ in
            let stubData = JSON_FORECAST.data(using: String.Encoding.utf8)
            return OHHTTPStubsResponse(data: stubData!, statusCode:200, headers:nil)
        }
        
        let asyncExpectation = expectation(description: "longRunningFunction")
        
        self.communicationController.citiesInCycle(latitude: 0.0, longitude: 0.0, quantity: 10) { [weak self] (listOfcities:Array<CityMappable>?, success:Bool, errorMessage:Error?) in
            
            guard let strongSelf = self else { return }
            
            guard success, let firstCity = listOfcities?.first else{
                XCTFail("The list of cities doesn't match with the expectation")
                return
            }
            
            strongSelf.cityTest(city: firstCity)
            
            asyncExpectation.fulfill()
        }

        self.waitForExpectations(timeout: 5) { error in
            
            XCTAssertNil(error, "Time out")
        }
    }
    
    
}
