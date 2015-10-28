//
//  MapViewDecorator.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/28/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import MapKit


class MapViewDecorator {
    
    var mapView: MKMapView
    
    init(mapView: MKMapView) {
        
        self.mapView = mapView
        
    }
    
    func goToCurrentPlace() {
        
        MapHelper.getCurrentPlace() { (coordinate) in
            self.mapView.setCenterCoordinate(coordinate, animated: true)
            
            // set camera
            let mapCamera = MKMapCamera(lookingAtCenterCoordinate: coordinate, fromEyeCoordinate: coordinate, eyeAltitude: 10000)
            self.mapView.setCamera(mapCamera, animated: true)

        }
        
    }
    
    func goToLocationWithPlaceID(id: String) {
        
        // go to location
        MapHelper.getPlaceByID(id) {
            (place) in
            
            let mapCamera = MKMapCamera(lookingAtCenterCoordinate: place.coordinate, fromEyeCoordinate: place.coordinate, eyeAltitude: 10000)
            self.mapView.setCamera(mapCamera, animated: true)
            
            // add pin
            let pin = MKPointAnnotation()
            pin.coordinate = place.coordinate
            pin.title = place.name
            pin.subtitle = place.formattedAddress
            self.mapView.addAnnotation(pin)
            
        }
        
    }
    
    func goToWaypoint(waypoint: Waypoint) {
        
        let latitude = Double(waypoint.latitude!)
        let longitude = Double(waypoint.longitude!)
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        let mapCamera = MKMapCamera(lookingAtCenterCoordinate: coordinate, fromEyeCoordinate: coordinate, eyeAltitude: 10000)
        self.mapView.setCamera(mapCamera, animated: false)
        
        // add pin
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = waypoint.name
        
        self.mapView.addAnnotation(pin)
        
    }
    
}