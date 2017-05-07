//
//  ListCitiesViewController.swift
//  WeatherApp
//
//  Created by Carlos Pages on 06/05/2017.
//  Copyright © 2017 cpages. All rights reserved.
//

import UIKit
import CoreLocation

class ListCitiesViewController: UIViewController {

    internal let NUMBER_OF_LOCATIONS_TO_REQUEST = 10;
    var dataController:DataController!
    var listOfCities = [City]()
    
    public var dataProvider:ListOfCitiesDataProvider = ListOfCitiesDataProvider()

    //UI
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.dataController == nil {
            self.dataController = DataController()
        }
    
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        tableView.dataSource = self.dataProvider
        self.dataProvider.tableview = tableView
        
        // Do any additional setup after loading the view.
    }
    
    //Location
    let locationManager = CLLocationManager()
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var userLocation:CLLocationCoordinate2D? {
        didSet {
            if let _ = userLocation, oldValue == nil {
                
                self._loadData()
            }
        }
    }
}

    // MARK: Private Methods
extension ListCitiesViewController {
    
    func _loadData() {
        
        guard let userLocation = self.userLocation else {
            return;
        }
        
        self.dataController.listOfCities(latitude: userLocation.latitude, longitude: userLocation.longitude, quantity: NUMBER_OF_LOCATIONS_TO_REQUEST) { [weak self] (listOfCities:Array<City>?, success:Bool, offline:Bool, error:Error?) in
            guard let `self` = self else { return }
            
            guard let listOfCitiesUW = listOfCities, success else {
                let alert = UIAlertController(title: NSLocalizedString("Error", comment: "Error title in alert controller"), message: NSLocalizedString("There was an error getting the list of cities", comment: "Error message getting the list of cities"), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK button in alertController"), style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            self.dataProvider.setCities(cities: listOfCitiesUW)
        }
    }
    
}
    // MARK: CLLocationManagerDelegate
extension ListCitiesViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        guard let firstLocation = locations.first else {
            return
        }
        
        self.userLocation = firstLocation.coordinate
    }
}
