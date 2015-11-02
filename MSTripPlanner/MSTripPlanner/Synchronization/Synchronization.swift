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
            (jsonTripStructs) in
            
            let moc = DataHelper.sharedInstance.moc
            
            let coreDataTrips = DataHelper.sharedInstance.fetchTrips()
            
            // post new core data trips
            let serverTripIDs = jsonTripStructs?.map() { (jsonTripStruct) in jsonTripStruct.id! }
            let newCoreDataTrips = coreDataTrips.filter() {
                (coreDataTrip) in
                
                !serverTripIDs!.contains(coreDataTrip.id!)
            }
            
            newCoreDataTrips.forEach() {
                (newCoreDataTrip) in
                
                APIClient().postTrip(newCoreDataTrip)
            }
            
            // get new server trips
            let coreDataTripIDs = coreDataTrips.map() { (coreDataTrip) in coreDataTrip.id! }
            let newServerTrips = jsonTripStructs?.filter() {
                (jsonTripStruct) in
                !coreDataTripIDs.contains(jsonTripStruct.id!)
            }
            
            newServerTrips?.forEach() {
                (newServerTrip) in
                
                let trip = Trip(context: moc, jsonTripStruct: newServerTrip)
                
                newServerTrip.waypoints?.forEach() {
                    (jsonWaypointStruct) in
                    
                    let waypoint = Waypoint(context: moc, jsonWaypointStruct: jsonWaypointStruct)
                    waypoint.trip = trip
                }
            }
            
            try! moc.save()
            
            let trips = DataHelper.sharedInstance.fetchTrips()
            callback(trips: trips)
        }
        
    }
    
    
}