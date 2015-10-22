//
//  Waypoint.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/21/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import CoreData

@objc(Waypoint)
class Waypoint: NSManagedObject {

    // MARK: Properties
    
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var name: String?
    @NSManaged var trip: Trip?

}
