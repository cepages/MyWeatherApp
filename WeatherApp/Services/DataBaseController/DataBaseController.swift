//
//  DataBaseController.swift
//  WeatherApp
//
//  Created by Carlos Pages on 06/05/2017.
//  Copyright © 2017 cpages. All rights reserved.
//

import Foundation
import CoreData

/*!
 @class DataBaseController
 
 @discussion This class represents the database. All the calls to this class are to persist objects in the db and to get objects from the db.
 */
class DataBaseController: NSObject {

    var persistentContainer:NSPersistentContainer
    lazy var managedObjectContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    init(memoryType:Bool, completionClosure: @escaping () -> ()) {
        persistentContainer = NSPersistentContainer(name: "WeatherApp")
        
        if memoryType {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            persistentContainer.persistentStoreDescriptions = [description]
        }
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completionClosure()
        }
    }
    
    /*!
     * This method persist in the db a city.
     * \param city we are gonna persist
     */
     func persistCity(cityName:String?,cityID:Int64?,temperatureMax:Float?,temperatureMin:Float?,weatherDescription:String?) throws -> (City) {
        
        let city:City = NSEntityDescription.insertNewObject(forEntityName: "City", into: self.managedObjectContext) as! City
        city.id = cityID ?? -1
        city.name = cityName
        city.temperatureMax = temperatureMax ?? 0
        city.temperatureMin = temperatureMin ?? 0
        city.weatherDescription = weatherDescription
        
        try self.managedObjectContext.save()
        
        return city
    }
    
    /*!
     * This method returns a list of cities from the db
     * \return List of cities in the db
     *
     */
    func listOfCities() throws -> (Array<City>) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        let fetchCity = try self.managedObjectContext.fetch(fetchRequest) as! [City]
        return fetchCity
    }
    
    /*!
     * This method delete all cities from the db
     */
    func removeAllCities() throws {
        
        let listOfCities = try self.listOfCities()
        for city in listOfCities {
            self.managedObjectContext.delete(city)
        }
        try self.managedObjectContext.save()
    }
}
