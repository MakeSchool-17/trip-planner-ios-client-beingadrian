//
//  DataHelper.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/22/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import CoreData


class DataHelper {
    
    // MARK: User methods
    
    static func seedUserWithUsername(username: String, password: String) {
        
        // create instance of managedObjectContext
        let moc = DataController().managedObjectContext
        
        // setup entity
        let userEntity = NSEntityDescription.insertNewObjectForEntityForName("UserEntity", inManagedObjectContext: moc) as! User
        
        // add data
        userEntity.setValue(username, forKey: "username")
        userEntity.setValue(password, forKey: "password")
        
        // save entity
        do {
            try moc.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
    }
    
    static func fetchUserWithUsername(username: String) {
        
        // create an instance of managedObjectContext
        let moc = DataController().managedObjectContext
        
        // define fetch request
        let userFetchRequest = NSFetchRequest(entityName: "UserEntity")
        
        // predicates
        let usernamePredicate = NSPredicate(format: "username == %@", username)
        
        // set predicate to request
        userFetchRequest.predicate = usernamePredicate
        
        // fetch user
        do {
            let fetchedUser = try moc.executeFetchRequest(userFetchRequest) as! [User]
            print(fetchedUser.first?.username)
        } catch {
            fatalError("Failed to fetch user: \(error)")
        }
        
    }
    
}