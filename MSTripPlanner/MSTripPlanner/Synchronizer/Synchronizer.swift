//
//  Synchronizer.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/31/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation


typealias SyncCallback = (trips: [Trip]) -> Void

class Synchronizer {
    
    static func sync(callback: SyncCallback) {
        
        // get trips from server
        APIClient.getTrips() {
            (trips) in
            
            // fetch trip ids from core data
            let coreDataTripIds = DataHelper.sharedInstance.fetchTrips().map() { $0.id! }
            
            let newServerTrips = trips?.filter() {
                !coreDataTripIds.contains($0.id)
            }
            
            // get managed object context
            let moc = DataHelper.sharedInstance.moc
            
            newServerTrips?.forEach() {
                // $0 = JSONTripStruct
                let trip = Trip(context: moc, jsonTripStruct: $0)
                
                $0.waypoints.forEach() {
                    // $0 = JSONWaypointStruct
                    let waypoint = Waypoint(context: moc, jsonWaypointStruct: $0)
                    waypoint.trip = trip
                }
            }
            
            try! moc.save()
            
            // get updated list of trips
            let tripsUpdated = DataHelper.sharedInstance.fetchTrips()
            callback(trips: tripsUpdated)
            
        }
        
    }
    
}