//
//  Trip.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/28/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import CoreData

@objc(Trip)
class Trip: NSManagedObject {

    convenience init(context: NSManagedObjectContext) {
        let entityDescription = NSEntityDescription.entityForName("TripEntity", inManagedObjectContext:
            context)!
        self.init(entity: entityDescription, insertIntoManagedObjectContext: context)
    }
    
    convenience init(context: NSManagedObjectContext, jsonTripStruct: JSONTripStruct) {
        let entityDescription = NSEntityDescription.entityForName("TripEntity", inManagedObjectContext:
            context)!
        self.init(entity: entityDescription, insertIntoManagedObjectContext: context)
        
        // get waypoints
        var waypointArray: [Waypoint] = []
        for waypointStruct in jsonTripStruct.waypoints {
            let waypoint = Waypoint(context: context, jsonWaypointStruct: waypointStruct)
            waypointArray.append(waypoint)
        }
        
        // set values
        self.name = jsonTripStruct.name
        self.id = jsonTripStruct.id
        self.waypoints = NSOrderedSet(array: waypointArray)
        
    }

}
