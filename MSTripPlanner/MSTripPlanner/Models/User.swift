//
//  User.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/21/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import CoreData

@objc(User)
class User: NSManagedObject {
    
    // MARK: Properties
    
    @NSManaged var password: String?
    @NSManaged var username: String?
    @NSManaged var trips: NSSet?

}
