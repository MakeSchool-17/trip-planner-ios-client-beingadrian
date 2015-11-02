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
        
        
        var waypointArray: [Waypoint] = []
        for jsonWaypointStruct in jsonTripStruct.waypoints! {
            let waypoint = Waypoint(context: context, jsonWaypointStruct: jsonWaypointStruct)
            waypointArray.append(waypoint)
        }
        
        name = jsonTripStruct.name
        id = jsonTripStruct.id
        waypoints = NSOrderedSet(array: waypointArray)
        
    }

}
