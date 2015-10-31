//
//  TripJSON.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/31/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation

typealias JSON = Dictionary<String, AnyObject>

struct TripJSON {
    
    let name: String
    let waypoints: [WaypointJSON]
    
    
    init(trip: Trip) {
        
        // create waypoints array
        var waypointsArray: [WaypointJSON] = []
        for waypoint in trip.waypoints!.array as! [Waypoint] {
            let waypointJSON = WaypointJSON(waypoint: waypoint)
            waypointsArray.append(waypointJSON)
        }
        
        self.name = trip.name!
        self.waypoints = waypointsArray
        
    }
    
    func toJSON() -> JSON {
        
        var waypointsArray: [JSON] = []
        
        for waypoint in waypoints {
            let waypointJSON = waypoint.toJSON()
            waypointsArray.append(waypointJSON)
        }
        
        let json: JSON = [
            "name": name,
            "waypoints": waypointsArray
        ]
        
        return json
    }
    
    
}