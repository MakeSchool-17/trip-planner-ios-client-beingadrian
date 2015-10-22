//
//  Trip.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/21/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import CoreData

@objc(Trip)
class Trip: NSManagedObject {

    // MARK: Properties
    
    @NSManaged var tripName: String?
    @NSManaged var owner: User?
    @NSManaged var waypoints: NSSet?

}
