//
//  Trip+CoreDataProperties.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/31/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Trip {

    @NSManaged var name: String?
    @NSManaged var id: String?
    @NSManaged var waypoints: NSOrderedSet?

}
