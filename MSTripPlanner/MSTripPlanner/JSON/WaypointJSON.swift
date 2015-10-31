//
//  WaypointJSON.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/31/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation


struct WaypointJSON {
    
    let name: String
    let longitude: Double
    let latitude: Double
    
    init(waypoint: Waypoint) {
        self.name = waypoint.name!
        self.longitude = waypoint.longitude! as Double
        self.latitude = waypoint.latitude! as Double
    }
    
    func toJSON() -> JSON {
        
        let json: Dictionary<String, AnyObject> = [
            "name": name,
            "longitude": longitude,
            "latitude": latitude
        ]
        
        return json
    }
    
}