//
//  MapHelper.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/27/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import GoogleMaps
import MapKit


class MapHelper {
    
    // MARK: Properties
    
    static let placesClient = GMSPlacesClient()
    
    
    // MARK: Methods
    
    static func requestUserPermission() {
        
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    static func getCurrentPlace(completion: (coordinate: CLLocationCoordinate2D) -> Void) {
        
        requestUserPermission()
        
        placesClient.currentPlaceWithCallback() {
            (placeLikelihoodList: GMSPlaceLikelihoodList?, error: NSError?) -> Void in
            
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let placeLicklihoodList = placeLikelihoodList {
                let place = placeLicklihoodList.likelihoods.first?.place
                if let place = place {
                    completion(coordinate: place.coordinate)
                }
            }

        }
        
    }
    
    static func getPlacesSearchResults(string: String, completion: (results: [GMSAutocompletePrediction]) -> Void) {
        
        placesClient.autocompleteQuery(string, bounds: nil, filter: nil) {
            (results, error: NSError?) -> Void in
            
            if let error = error {
                print("Autocomplete error: \(error)")
            }
            
            if let results = results as? [GMSAutocompletePrediction] {
                completion(results: results)
            }
            
        }
        
    }
    
    static func getPlaceByID(id: String, completion: (place: GMSPlace) -> Void) {
        
        placesClient.lookUpPlaceID(id) {
            (place: GMSPlace?, error: NSError?) -> Void in
            
            if let error = error {
                print("Lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            if let place = place {
                completion(place: place)
            }
            
        }
        
    }
    
}