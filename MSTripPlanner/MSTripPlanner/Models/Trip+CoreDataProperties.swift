//
//  Trip+CoreDataProperties.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 11/2/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Trip {

    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var lastUpdate: NSDate?
    @NSManaged var waypoints: NSOrderedSet?

}
