//
//  WaypointViewController.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/19/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit
import MapKit


class WaypointViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var mapView: MKMapView!
    
    var mapViewDecorator: MapViewDecorator?
    var waypoint: Waypoint?
    
    
    // MARK: Base methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapViewDecorator = MapViewDecorator(mapView: mapView)
        
        // go to location
        if let waypoint = waypoint {
            let latitude = Double(waypoint.latitude!)
            let longitude = Double(waypoint.longitude!)
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            mapViewDecorator?.goToLocationWithCoordinate(coordinate)
        }

    }

    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    override func prefersStatusBarHidden() -> Bool { return true }

}
