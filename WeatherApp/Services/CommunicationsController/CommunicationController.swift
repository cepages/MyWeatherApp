//
//  CommunicationController.swift
//  WeatherApp
//
//  Created by Carlos Pages on 06/05/2017.
//  Copyright © 2017 cpages. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import Foundation
import SystemConfiguration

internal let HOST = "api.openweathermap.org"
internal let APP_ID = "aa3adf743a3e77f8bab213044d705db4"
internal let MAIN_URL = "http://\(HOST)/data/2.5/"
internal let APP_ID_PATH = "&appid=\(APP_ID)"

extension String: Error { }

class CommunicationsController:NSObject  {
    
    /*!
     * This method check the internet connection
     */
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    /*!
     * This method returns the list of cities from a latitude and longitude provided. The number of of cities returned will be restricted to the quantity provided
     * \param latitude The latitude to get the cities around
     * \param longitude The latitude to get the cities around
     * \param quantity Maximum number of cities will be returned.
     * \param handler Block called when the request is finished. Params: cities: The cities found around the location provided. success: If the request was successful. errorMessage: String with a message with the error if something went wrong. 
     */
    func citiesInCycle(latitude:Double, longitude:Double, quantity:Int,handler:@escaping (_ cities:Array<CityMappable>?, _ success:Bool, _ errorMessage:Error?)->Void) -> (){
        
        let path = "find?lat=\(latitude)&lon=\(longitude)&cnt=\(quantity)"
        let finalURL = self._createFinalUrl(path: path)

 
        Alamofire.request(finalURL).responseArray(queue: nil, keyPath: "list", context: nil) { (response:DataResponse<[CityMappable]>) in
            
            guard response.response?.statusCode == 200, let listOfCitiesMappable = response.result.value else {
                let error = "There was a problem parsing the city"
                handler(nil, false, error)
                return
            }
            handler(listOfCitiesMappable, true, nil)
        }
    }
}

    //MARK: - Private 
extension CommunicationsController{
    
    func _createFinalUrl(path:String) -> String{
        return MAIN_URL + path + APP_ID_PATH
    }
}
