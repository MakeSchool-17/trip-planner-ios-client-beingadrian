//
//  WaypointJSON.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/31/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation

typealias JSONWaypoint = Dictionary<String, AnyObject>


struct JSONWaypointStruct {
    
    let name: String
    let longitude: Double
    let latitude: Double
    
    
    init?(json: JSONWaypoint) {
        self.name = (json["name"]! as! String)
        self.longitude = json["longitude"] as! Double
        self.latitude = json["latitude"] as! Double
    }
    
    init(waypoint: Waypoint) {
        self.name = waypoint.name!
        self.longitude = waypoint.longitude! as Double
        self.latitude = waypoint.latitude! as Double
    }
    
    func toJSON() -> JSONWaypoint {
        
        let json: Dictionary<String, AnyObject> = [
            "name": name,
            "longitude": longitude,
            "latitude": latitude
        ]
        
        return json
    }
    
}