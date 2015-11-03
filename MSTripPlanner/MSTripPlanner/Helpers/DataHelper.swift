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
    
    // singleton
    static let sharedInstance = DataHelper()
    
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
    
    let moc = DataController().managedObjectContext
    
    // deleted trips
    var deletedTripsIDs: [String] = []
    
    
    // MARK: - Trip methods
    
    func addTripWithName(name: String) -> Trip {
        
        // setup entity
        let tripEntity = NSEntityDescription.insertNewObjectForEntityForName(TripEntityName, inManagedObjectContext: moc) as! Trip
        
        // add data
        tripEntity.name = name
        tripEntity.id = String(ObjectIdentifier(tripEntity).uintValue)
        
        // save entity
        do {
            try moc.save()
            print("Save successful")
            return tripEntity
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
    }
    
    func fetchTripWithObjectID(objectID: NSManagedObjectID) -> Trip? {
        
        do {
            if let trip = try moc.existingObjectWithID(objectID) as? Trip {
                return trip
            } else {
                return nil
            }
        } catch {
            fatalError("Failed to fetch trip: \(error)")
        }
        
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
    
    func deleteTripWithObjectID(objectID: NSManagedObjectID) {
        
        // fetch trip to delete
        guard let tripToDelete = fetchTripWithObjectID(objectID) else { return }
        
        deletedTripsIDs.append(tripToDelete.id!)
        
        // delete trip
        moc.deleteObject(tripToDelete)
        
        do {
            try moc.save()
        } catch {
            fatalError("Failed to save context after deletion: \(error)")
        }
    }
    
    
    // MARK: - Waypoint methods
    
    func addWaypointWithName(name: String, longitude: Float, latitude: Float) -> Waypoint {
        
        let waypointEntity = NSEntityDescription.insertNewObjectForEntityForName(WaypointEntityName, inManagedObjectContext: moc) as! Waypoint
        
        // add other waypoint data
        waypointEntity.name = name
        waypointEntity.latitude = latitude
        waypointEntity.longitude = longitude
        waypointEntity.id = String(ObjectIdentifier(waypointEntity).uintValue)
        
        // save entity
        do {
            try moc.save()
            print("Saved waypoint succesfully")
        } catch {
            fatalError("Failed to save waypoint: \(error)")
        }
        
        return waypointEntity
    }
    
    func fetchWaypointWithObjectID(objectID: NSManagedObjectID) -> Waypoint? {
        
        do {
            if let waypoint = try moc.existingObjectWithID(objectID) as? Waypoint {
                return waypoint
            } else {
                return nil
            }
        } catch {
            fatalError("Error fetching waypoint with id: \(error)")
        }
    
    }
    
    func fetchWaypoints() -> [Waypoint] {
        
        let waypointsFetchRequest = NSFetchRequest(entityName: WaypointEntityName)
        
        // fetch waypoints
        do {
            let fetchedWaypoints = try moc.executeFetchRequest(waypointsFetchRequest) as! [Waypoint]
            return fetchedWaypoints
        } catch {
            fatalError("Failed to fetch waypoints: \(error)")
        }
        
    }
    
    func deleteWaypointWithID(objectID: NSManagedObjectID) {
        
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