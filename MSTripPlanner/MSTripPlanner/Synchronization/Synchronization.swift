//
//  Synchronization.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 11/2/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation


typealias SyncCallback = (trips: [Trip]) -> Void


class Synchronizer {
    
    func sync(callback: SyncCallback) {
        
        APIClient().getTrips() {
            (serverTripStructs) in
            
            let coreDataTrips = DataHelper.sharedInstance.fetchTrips()
            
            if let serverTripStructs = serverTripStructs {
                // update trips with updated waypoints (changed)
                self.postUpdatedTrips()
                
                // post new core data trips
                self.postNewCoreDataTrips(serverTripStructs, coreDataTrips: coreDataTrips)
                
                // get new server trips
                self.getNewServerTrips(serverTripStructs, coreDataTrips: coreDataTrips)
                
                self.updateDeletedTrips(serverTripStructs)
                
                let trips = DataHelper.sharedInstance.fetchTrips()
                callback(trips: trips)
            }
            
        }
        
    }
    
    func postNewCoreDataTrips(serverTripStructs: [JSONTripStruct], coreDataTrips: [Trip]) {
        
        let serverTripIDs = serverTripStructs.map() { (jsonTripStruct) in jsonTripStruct.id! }
        let newCoreDataTrips = coreDataTrips.filter() {
            (coreDataTrip) in
            
            !serverTripIDs.contains(coreDataTrip.id!)
        }
        
        newCoreDataTrips.forEach() {
            (newCoreDataTrip) in
            
            APIClient().postTrip(newCoreDataTrip)
        }
        
    }
    
    func getNewServerTrips(serverTripStructs: [JSONTripStruct], coreDataTrips: [Trip]) {
        
        let coreDataTripIDs = coreDataTrips.map() { (coreDataTrip) in coreDataTrip.id! }
        let newServerTrips = serverTripStructs.filter() {
            (jsonTripStruct) in
            
            !coreDataTripIDs.contains(jsonTripStruct.id!) && !DataHelper.sharedInstance.deletedTripsIDs.contains(jsonTripStruct.id!)
        }
    
        let moc = DataHelper.sharedInstance.moc
        
        newServerTrips.forEach() {
            (newServerTrip) in
            
            let trip = Trip(context: moc, jsonTripStruct: newServerTrip)
            
            newServerTrip.waypoints?.forEach() {
                (jsonWaypointStruct) in
                
                let waypoint = Waypoint(context: moc, jsonWaypointStruct: jsonWaypointStruct)
                waypoint.trip = trip
            }
        }
        
        do {
            try moc.save()
        } catch {
            fatalError("Error saving new trips fetched from server: \(error)")
        }
        
    }
    
    func updateDeletedTrips(serverTripStructs: [JSONTripStruct]) {
        
        let deletedTripsIDs = DataHelper.sharedInstance.deletedTripsIDs
        
        let tripsToDelete = serverTripStructs.filter() {
            (serverTripStruct) in
            
            deletedTripsIDs.contains(serverTripStruct.id!)
        }
        
        for trip in tripsToDelete {
            APIClient().deleteTripWithID(trip.id!)
        }

        
    }
    
    func postUpdatedTrips() {
        
        let coreDataTrips = DataHelper.sharedInstance.fetchTrips()
        
        if coreDataTrips.count != 0 {
            for trip in coreDataTrips {
                if trip.lastUpdate!.isGreaterThanDate(DataHelper.sharedInstance.lastSync) {
                    APIClient().putTrip(trip)
                }
            }
        }
        
    }
    
}