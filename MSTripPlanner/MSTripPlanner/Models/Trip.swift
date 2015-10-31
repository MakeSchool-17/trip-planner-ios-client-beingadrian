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
    
    convenience init(context: NSManagedObjectContext, jsonTrip: JSON) {
        let entityDescription = NSEntityDescription.entityForName("TripEntity", inManagedObjectContext:
            context)!
        self.init(entity: entityDescription, insertIntoManagedObjectContext: context)
        
        // parse waypoint json data
        let waypointArrayJSON = jsonTrip["waypoints"]! as! [JSON]
        
        var array: [Waypoint] = []
        for waypoint in waypointArrayJSON {
            let wp = Waypoint(context: context, jsonWaypoint: waypoint)
            array.append(wp)
        }
        
        let waypointOrderedSet = NSOrderedSet(array: array)
        
        // set values
        name = (jsonTrip["name"]! as! String)
        waypoints = waypointOrderedSet
        
    }

}
