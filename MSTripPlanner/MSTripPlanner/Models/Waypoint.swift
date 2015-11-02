//
//  Waypoint.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/28/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import CoreData

@objc(Waypoint)
class Waypoint: NSManagedObject {

    convenience init(context: NSManagedObjectContext) {
        
        let entityDescription = NSEntityDescription.entityForName("WaypointEntity", inManagedObjectContext:
            context)!
        self.init(entity: entityDescription, insertIntoManagedObjectContext: context)
        
    }
    
    convenience init(context: NSManagedObjectContext, jsonWaypointStruct: JSONWaypointStruct) {
        
        let entityDescription = NSEntityDescription.entityForName("WaypointEntity", inManagedObjectContext:
            context)!
        self.init(entity: entityDescription, insertIntoManagedObjectContext: context)
        
        name = jsonWaypointStruct.name
        longitude = jsonWaypointStruct.longitude
        latitude = jsonWaypointStruct.latitude
        id = jsonWaypointStruct.id
        
    }

}
