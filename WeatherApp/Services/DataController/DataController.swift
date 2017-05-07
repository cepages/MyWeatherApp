//
//  DataController.swift
//  WeatherApp
//
//  Created by Carlos Pages on 06/05/2017.
//  Copyright © 2017 cpages. All rights reserved.
//

import Foundation
/*!
 @class DataController
 
 @discussion This class represents the data. This class uses CommunicationsController and DataBaseController to provide the data depending the status of the network. It the app is offline the data will be from the data base. If the app is online the methods will update the database and they will provide the data from the data base. 
 @todo We could use etags to save time converting data. So if the etag is the same in the server and in the app, nothing has changed so I can return the data from the database.
 */
class DataController: NSObject {

    var dataBaseController:DataBaseController
    var communicationsController:CommunicationsController
    override init() {

        dataBaseController = DataBaseController(memoryType: false, completionClosure: { 
            
        })
        
        communicationsController = CommunicationsController()
    }
    
    
    /*!
     * This method returns a list of Cities. If there is any error or the communications are offline it will return the last list of cities in the DB.
     * \param successful Closure that is called when the request is successful
     * \param failure Clousure that is called when the request fails
     */
    func listOfCities(latitude:Double, longitude:Double, quantity:Int, handler:@escaping (Array<City>?, _ success:Bool, _ workingOffline:Bool, _ error:Error?) -> Void) -> ()   {
        
        if !type(of: self.communicationsController).isConnectedToInternet() {
            do {
                let listOfCities = try self.dataBaseController.listOfCities()
                handler(listOfCities,true,true,nil)
            }
            catch let error {
                handler(nil,false,true,error)
            }
            return
        }
        
        //We call to the communications to get the cities
        self.communicationsController.citiesInCycle(latitude: latitude, longitude: longitude, quantity: quantity) { [weak self] (listOfCitiesMappables:Array<CityMappable>?, success:Bool, error:Error?) in
            
            guard let `self` = self else {
                handler(nil,false,false,"Error managing memory")
                return
            }
            
            if let listOfCitiesMappablesUW = listOfCitiesMappables, success{
                
                var listOfCities = [City]()
                
                do {
                    //We delete other cities in the db
                    try self.dataBaseController.removeAllCities()
                    
                    for cityMappable in listOfCitiesMappablesUW {
                        //We insert our cities in db
                        let city = try self.dataBaseController.persistCity(cityName: cityMappable.cityName, cityID: Int64(cityMappable.cityID ?? -1), temperatureMax: cityMappable.maxTemperature, temperatureMin: cityMappable.minTemperature, weatherDescription: cityMappable.weatherDescription)
                        
                        listOfCities.append(city)
                    }
                    handler(listOfCities,true,false,nil)

                } catch let error {
                    handler(nil,false,false,error)
                }
            }
            else{
                handler(nil,false,false,"Error downloading the list of cities")
            }
        }
    }
}
