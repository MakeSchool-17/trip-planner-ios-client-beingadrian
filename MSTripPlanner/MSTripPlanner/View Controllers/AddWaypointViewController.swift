//
//  AddWaypointViewController.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/19/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps


class AddWaypointViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    var mapViewDecorator: MapViewDecorator!
    var matchedPlaces: [GMSAutocompletePrediction] = []
    var selectedPlace: GMSPlace?

    var trip: Trip?
    
    
    // MARK: Base methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        mapViewDecorator = MapViewDecorator(mapView: mapView)
        
        // design implementations
        let navDecorator = BarDecorator(navigationBar: navigationBar)
        navDecorator.changeBarTintColor()
        navDecorator.setTitleFont()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        mapViewDecorator.goToCurrentPlace()
        
    }
    
    func setup() {
        
        // search table view setup
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        // search bar setup
        searchBar.delegate = self
        
        searchTableView.hidden = true
        
    }

    
    // MARK: Actions
    
    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func saveBarButtonPressed(sender: UIBarButtonItem) {
        
        // get place details for waypoint
        if let place = selectedPlace {
            let waypointName = place.name
            let waypointLongitude = Float(place.coordinate.longitude)
            let waypointLatitude = Float(place.coordinate.latitude)
            
            // add waypoint to core data
            let waypoint = DataHelper.sharedInstance.addWaypointWithName(waypointName, longitude: waypointLongitude, latitude: waypointLatitude)
            
            // create relationship
            if let trip = trip {
                let associatedTrip = DataHelper.sharedInstance.fetchTripWithObjectID(trip.objectID)
                waypoint.trip = associatedTrip
                
                // update lastUpdated trip property
                trip.lastUpdate = NSDate()
                
                do {
                    try DataHelper.sharedInstance.moc.save()
                } catch {
                    fatalError("Erro saving relationship: \(error)")
                }
            }
            
            dismissViewControllerAnimated(true, completion: nil)
        }
    
    }
    
}

extension AddWaypointViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let predictedPlace = matchedPlaces[indexPath.row]
        let predictedPlaceID = predictedPlace.placeID
        
        // assign selectedPlace with the predicted place by getting the place initially
        MapHelper.getPlaceByID(predictedPlaceID) {
            (place) in
            
            self.selectedPlace = place
        }
        
        // set search bar text
        searchBar.text = predictedPlace.attributedFullText.string
        
        // remove responder
        searchBar.resignFirstResponder()
        
        searchTableView.hidden = true
        
        mapViewDecorator.goToLocationWithPlaceID(predictedPlaceID)
        
    }
    
}

extension AddWaypointViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return matchedPlaces.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let place = matchedPlaces[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaceCell") as! PlaceCell
        
        cell.placeNameLabel.text = place.attributedFullText.string
        
        return cell
        
    }
    
}

extension AddWaypointViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        searchTableView.hidden = false
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.characters.count > 0 {
            MapHelper.getPlacesSearchResults(searchText) {
                (results) in
                self.matchedPlaces = results
            }
        } else {
            matchedPlaces = []
        }
        
        searchTableView.reloadData()
        
    }
    
}
