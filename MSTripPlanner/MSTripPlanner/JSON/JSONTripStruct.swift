//
//  TripJSON.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/31/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation

typealias JSONTrip = Dictionary<String, AnyObject>

struct JSONTripStruct {
    
    let name: String
    let id: String
    let waypoints: [JSONWaypointStruct]
    
    
    init?(json: JSONTrip) {

        // parse waypoint json data
        let jsonWaypointArray = json["waypoints"]! as! [JSONWaypoint]
        
        var waypointArray: [JSONWaypointStruct] = []
        for jsonWaypoint in jsonWaypointArray {
            let wp = JSONWaypointStruct(json: jsonWaypoint)!
            waypointArray.append(wp)
        }
        
        // set values
        name = (json["name"]! as! String)
        id = (json["id"]! as! String)
        waypoints = waypointArray
    }
    
    init(trip: Trip) {
        
        // create waypoints array
        var waypointsArray: [JSONWaypointStruct] = []
        for waypoint in trip.waypoints!.array as! [Waypoint] {
            let waypointJSON = JSONWaypointStruct(waypoint: waypoint)
            waypointsArray.append(waypointJSON)
        }
        
        self.name = trip.name!
        self.id = String(ObjectIdentifier(trip).uintValue)
        self.waypoints = waypointsArray
        
    }
    
    func toJSON() -> JSONTrip {
        
        var waypointsArray: [JSONTrip] = []
        
        for waypoint in waypoints {
            let waypointJSON = waypoint.toJSON()
            waypointsArray.append(waypointJSON)
        }
        
        let json: JSONTrip = [
            "name": name,
            "id": id,
            "waypoints": waypointsArray
        ]
        
        return json
    }
    
    
}