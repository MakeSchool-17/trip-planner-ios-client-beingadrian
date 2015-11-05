//
//  JSONWaypointStruct.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 11/2/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import Gloss


struct JSONWaypointStruct: Glossy {
    
    let name: String?
    let longitude: Double?
    let latitude: Double?
    let id: String?
    let lastUpdate: String?
    
    
    init(name: String, longitude: Double, latitude: Double, id: String, lastUpdate: String) {
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
        self.id = id
        self.lastUpdate = lastUpdate
    }
    
    init?(json: JSON) {
        self.name = "name" <~~ json
        self.longitude = "longitude" <~~ json
        self.latitude = "latitude" <~~ json
        self.id = "id" <~~ json
        self.lastUpdate = "lastUpdate" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> self.name,
            "longitude" ~~> self.longitude,
            "latitude" ~~> self.latitude,
            "id" ~~> self.id,
            "lastUpdate" ~~> self.lastUpdate
        ])
    }
    
}


