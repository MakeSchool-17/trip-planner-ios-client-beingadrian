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
            
        }
        
    }
    
    func goToLocationWithCoordinate(coordinate: CLLocationCoordinate2D) {
        
        let mapCamera = MKMapCamera(lookingAtCenterCoordinate: coordinate, fromEyeCoordinate: coordinate, eyeAltitude: 10000)
        self.mapView.setCamera(mapCamera, animated: true)
        
    }
    
}