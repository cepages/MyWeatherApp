//
//  ListOfCitiesViewControllerTests.swift
//  WeatherApp
//
//  Created by Carlos Pages on 06/05/2017.
//  Copyright © 2017 cpages. All rights reserved.
//

import XCTest
@testable import WeatherApp

class ListOfCitiesViewControllerTests: XCTestCase {
    
    var viewController:ListCitiesViewController!
    var dataBaseController:DataBaseController!
    
    let CITY_NAME = "City Test"
    let CITY_ID:Int64 = 123
    let CITY_TEMPERATURE_MAX:Float = 188.54
    let CITY_TEMPERATURE_MIN:Float = 154.34
    let CITY_WEATHER_DESCRIPTION = "This is a test weather description"
    
    let CITY_NAME2 = "City Test 2"
    let CITY_ID2:Int64 = 124
    let CITY_TEMPERATURE_MAX2:Float = 345.3
    let CITY_TEMPERATURE_MIN2:Float = 54.34
    let CITY_WEATHER_DESCRIPTION2 = "This is a test weather description 2"

    override func setUp() {
        super.setUp()
        self.dataBaseController = DataBaseController.init(memoryType:true, completionClosure: {
            
        })
        self.viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListCitiesViewController") as! ListCitiesViewController
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewControllerShows2Rows () {
        
        //Given
        do {
            let city1 = try self.dataBaseController.persistCity(cityName: CITY_NAME, cityID: CITY_ID, temperatureMax: CITY_TEMPERATURE_MAX, temperatureMin: CITY_TEMPERATURE_MIN, weatherDescription: CITY_WEATHER_DESCRIPTION)
            let city2 = try self.dataBaseController.persistCity(cityName: CITY_NAME2, cityID: CITY_ID2, temperatureMax: CITY_TEMPERATURE_MAX2, temperatureMin: CITY_TEMPERATURE_MIN2, weatherDescription: CITY_WEATHER_DESCRIPTION2)
            
            let listOfCities = [city1,city2]

            viewController.dataProvider = ListOfCitiesDataProvider();
            // I need to access to the view to trigger the viewDidLoad()
            let _ = viewController.view
            viewController.dataProvider.setCities(cities: listOfCities)

            XCTAssert(viewController.tableView.numberOfRows(inSection: 0) == listOfCities.count, "The number of rows should be 2")
        } catch _ {
            XCTFail("Error in db")
        }
    }
}
