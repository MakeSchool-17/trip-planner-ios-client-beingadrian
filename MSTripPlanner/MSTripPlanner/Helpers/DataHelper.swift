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
    
    // MARK: Constants
    
    private let TripEntityName = "TripEntity"
    private let WaypointEntityName = "WaypointEntity"
    
    private let TripNameKey = "name"
    private let TripOwnerKey = "owner"
    private let TripWaypointsKey = "waypoints"
    
    private let WaypointLatitudeKey = "latitude"
    private let WaypointLongitudeKey = "longitude"
    private let WaypointNameKey = "name"
    private let WaypointTripKey = "trip"
    
    // managedObjectContext
    let moc = DataController().managedObjectContext
    
    
    // MARK: - Trip methods
    
    func seedTripWithName(name: String) {
        
        // setup entity
        let tripEntity = NSEntityDescription.insertNewObjectForEntityForName(TripEntityName, inManagedObjectContext: moc) as! Trip
        
        // add data
        tripEntity.setValue(name, forKey: TripNameKey)
        
        // save entity
        do {
            try moc.save()
            print("Save successful")
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
    }
    
    func fetchTripWithObjectID(objectID: String) -> Trip? {
        
        // define fetch request
        let tripFetchRequest = NSFetchRequest(entityName: TripEntityName)
        
        // objectID predicate
        let predicate = NSPredicate(format: "objectID == '\(objectID)'")
        
        // set predicate to request
        tripFetchRequest.predicate = predicate
        
        // request
        do {
            let fetchedTrips = try moc.executeFetchRequest(tripFetchRequest) as! [Trip]
            if let fetchedTrip = fetchedTrips.first {
                return fetchedTrip
            }
        } catch {
            fatalError("Failed to fetch trips: \(error)")
        }
        
        return nil
    }
    
    func fetchTrips() -> [Trip] {
        
        let tripsFetchRequest = NSFetchRequest(entityName: TripEntityName)
        
        do {
            let fetchedTrips = try moc.executeFetchRequest(tripsFetchRequest) as! [Trip]
            return fetchedTrips
        } catch {
            fatalError("Failed to fetch trips: \(error)")
        }
        
    }
    
    func deleteTripWithObjectID(objectID: String) {
        
        // fetch trip to delete
        guard let tripToDelete = fetchTripWithObjectID(objectID) else { return }
        
        // delete trip
        moc.deleteObject(tripToDelete)
        
        do {
            try moc.save()
        } catch {
            fatalError("Failed to save context after deletion: \(error)")
        }
    }
    
    
    // MARK: - Waypoint methods
    
    func seedWaypointWithName(name: String, longitude: Float, latitude: Float) -> Waypoint {
        
        let waypointEntity = NSEntityDescription.insertNewObjectForEntityForName(WaypointEntityName, inManagedObjectContext: moc) as! Waypoint
        
        // add other waypoint data
        waypointEntity.name = name
        waypointEntity.latitude = latitude
        waypointEntity.longitude = longitude
        
        // save entity
        do {
            try moc.save()
            print("Saved waypoint succesfully")
        } catch {
            fatalError("Failed to save waypoint: \(error)")
        }
        
        return waypointEntity
    }
    
    func fetchWaypointWithObjectID(objectID: String) -> Waypoint? {
        
        // define fetch request
        let waypointFetchRequest = NSFetchRequest(entityName: WaypointEntityName)
        
        // objectID predicate
        let predicate = NSPredicate(format: "objectID == '\(objectID)'")
        
        // set predicate to request
        waypointFetchRequest.predicate = predicate
        
        // request
        do {
            let fetchedWaypoints = try moc.executeFetchRequest(waypointFetchRequest) as! [Waypoint]
            if let fetchedWaypoint = fetchedWaypoints.first {
                return fetchedWaypoint
            }
        } catch {
            fatalError("Failed to fetch trips: \(error)")
        }
        
        return nil
    
    }
    
    func fetchWaypoints() -> [Waypoint]? {
        
        let waypointsFetchRequest = NSFetchRequest(entityName: WaypointEntityName)
        
        // fetch waypoints
        do {
            let fetchedWaypoints = try moc.executeFetchRequest(waypointsFetchRequest) as! [Waypoint]
            return fetchedWaypoints
        } catch {
            fatalError("Failed to fetch waypoints: \(error)")
        }
        
        return nil
    }
    
    func updateWaypointWithObjectID(objectID: String, name: String?, longitude: Float?, latitude: Float?) {
        
        guard let waypointToUpdate = fetchWaypointWithObjectID(objectID) else { return }
        
        // save data
        if let name = name, let longitude = longitude, let latitude = latitude {
            waypointToUpdate.name = name
            waypointToUpdate.longitude = longitude
            waypointToUpdate.latitude = latitude
        }
        
        // save moc 
        do {
            try moc.save()
        } catch {
            fatalError("Failed to save context after updating waypoint: \(error)")
        }
        
    }
    
    func deleteWaypointWithID(objectID: String) {
        
        // fetch waypoint to delete
        guard let waypointToDelete = fetchWaypointWithObjectID(objectID) else { return }
        
        // delete waypoint
        moc.deleteObject(waypointToDelete)
        
        do {
            try moc.save()
        } catch {
            fatalError("Failed to save context after deletion: \(error)")
        }
        
    }
    
}