//
//  JSONTripStruct.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 11/2/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import Gloss


struct JSONTripStruct: Glossy {
    
    let name: String?
    let id: String?
    let waypoints: [JSONWaypointStruct]?
    
    
    init(name: String, id: String, waypoints: [JSONWaypointStruct]) {
        self.name = name
        self.id = id
        self.waypoints = waypoints
    }
    
    init?(json: JSON) {
        self.name = "name" <~~ json
        self.id = "id" <~~ json
        self.waypoints = "waypoints" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> self.name,
            "id" ~~> self.id,
            "waypoints" ~~> self.waypoints
        ])
    }
    
}