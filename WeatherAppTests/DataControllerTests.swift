//
//  DataControllerTests.swift
//  WeatherApp
//
//  Created by Carlos Pages on 07/05/2017.
//  Copyright © 2017 cpages. All rights reserved.
//

import XCTest
@testable import WeatherApp

class DataControllerTests: XCTestCase {
    
    static let MAX_TEMPERATURE_1:Float = 284.67
    static let MIN_TEMPERTURE_1:Float = 262.45
    static let WEATHER_DESCRIPTION_1 = "Sky is Clear"
    static let CITY_ID_1:Int = 514297
    static let CITY_NAME_1 = "Ostafyevo"
    
    static let MAX_TEMPERATURE_2:Float = 125.0
    static let MIN_TEMPERTURE_2:Float = 54.34
    static let WEATHER_DESCRIPTION_2 = "Sky is Clear"
    static let CITY_ID_2:Int = 1236
    static let CITY_NAME_2 = "Murcia"
    
    var dataController:DataController!
    var dataBaseController:DataBaseController!
    override func setUp() {
        super.setUp()
        
        self.dataBaseController = DataBaseController.init(memoryType:true, completionClosure: {
            
        })
        self.dataController = DataController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testListOfCitiesWithInternetConnection () {
        
        class MockCommunicationsController: CommunicationsController {
            
            var city1:CityMappable?
            var city2:CityMappable?
            
            override class func isConnectedToInternet() ->Bool {
                return true
            }
            
            override func citiesInCycle(latitude:Double, longitude:Double, quantity:Int,handler:@escaping (_ cities:Array<CityMappable>?, _ success:Bool, _ errorMessage:Error?)->Void) -> (){
                
                let city1 = CityMappable()
                city1.cityName = DataControllerTests.CITY_NAME_1
                city1.cityID = DataControllerTests.CITY_ID_1
                city1.maxTemperature = DataControllerTests.MAX_TEMPERATURE_1
                city1.minTemperature = DataControllerTests.MIN_TEMPERTURE_1
                city1.weatherDescription = DataControllerTests.WEATHER_DESCRIPTION_1
                self.city1 = city1
                
                let city2 = CityMappable()
                city2.cityName = DataControllerTests.CITY_NAME_2
                city2.cityID = DataControllerTests.CITY_ID_2
                city2.maxTemperature = DataControllerTests.MAX_TEMPERATURE_2
                city2.minTemperature = DataControllerTests.MIN_TEMPERTURE_2
                city2.weatherDescription = DataControllerTests.WEATHER_DESCRIPTION_2
                self.city2 = city2
                
                handler([city1,city2],true,nil)
            }
        }
        
        let mockCommunicationsController = MockCommunicationsController()
        
        self.dataController.communicationsController = mockCommunicationsController;
        self.dataController.dataBaseController = self.dataBaseController
        
        let asyncExpectation = expectation(description: "longRunningFunction")

        self.dataController.listOfCities(latitude: 1, longitude: 1, quantity: 2) { [weak self] (listOfCities:Array<City>?, sucess:Bool, offline:Bool, error:Error?) in
            guard let strongSelf = self else { XCTFail(); return}
            
            XCTAssert(sucess, "The request was not successful")
            XCTAssert(!offline, "The request should not be offline")
            XCTAssert(listOfCities?.count == 2, "There should be two cities")
            
            let city1 = listOfCities?.first
            let city2 = listOfCities?[1]
            
            XCTAssert(strongSelf._compareMappableCityWithCity(mappableCity: mockCommunicationsController.city1!, city: city1!),"Cities don't match")
            XCTAssert(strongSelf._compareMappableCityWithCity(mappableCity: mockCommunicationsController.city2!, city: city2!),"Cities don't match")
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5) { error in
            
            XCTAssertNil(error, "Time out")
        }
        
    }
    
}
    //MARK: Private Methods
extension DataControllerTests {
    
    func _compareMappableCityWithCity(mappableCity:CityMappable, city:City) -> Bool {
        
        guard Int64(mappableCity.cityID!) == city.id else {
            return false
        }
        
        guard mappableCity.cityName == city.name else {
            return false
        }
        
        guard mappableCity.maxTemperature == city.temperatureMax else {
            return false
        }
        
        guard mappableCity.minTemperature == city.temperatureMin else {
            return false
        }
        
        guard mappableCity.weatherDescription == city.weatherDescription else {
            return false
        }
        
        return true
    }
}
