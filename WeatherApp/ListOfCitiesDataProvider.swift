//
//  ListOfCitiesDataProvider.swift
//  WeatherApp
//
//  Created by Carlos Pages on 06/05/2017.
//  Copyright © 2017 cpages. All rights reserved.
//

import UIKit

/*!
 @class ListOfCitiesDataProvider
 
 @discussion This class feeds the table. We have create this provider so the viewcontroller is easier to test
 */
class ListOfCitiesDataProvider: NSObject,ListOfCitiesDataProviderProtocol {

    weak var tableview:UITableView!
    
    internal var listOfCities:[City] = []
    
    func setCities(cities:[City])
    {
        self.listOfCities = cities
        self.tableview.reloadData()
    }
    
    func addCity(city:City)
    {
        self.listOfCities.append(city)
        let indexPath = IndexPath(row: self.listOfCities.count - 1, section: 0)
        self.tableview.insertRows(at: [indexPath], with: .bottom)
    }
}

private let CELL_ID = "WeatherCell"

extension ListOfCitiesDataProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.listOfCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
        guard let cityCell = cell as? CityWeatherTableViewCell  else {
            return cell
        }
        
        let city = self.listOfCities[indexPath.row]
        cityCell.updateCellWith(city: city)
        
        return cityCell
    }
    
}
