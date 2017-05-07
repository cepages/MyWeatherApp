//
//  ListOfCitiesDataProviderProtocol.swift
//  WeatherApp
//
//  Created by Carlos Pages on 06/05/2017.
//  Copyright © 2017 cpages. All rights reserved.
//

import Foundation
import UIKit

/*!
 @protocol ListOfCitiesDataProviderProtocol
 
 @discussion This protocol requires all necesary to feed the tableview to show the list of cities
 */
protocol ListOfCitiesDataProviderProtocol:UITableViewDataSource {
    
    weak var tableview:UITableView! { get set }
    func addCity(city:City)
    func setCities(cities:[City])

}
