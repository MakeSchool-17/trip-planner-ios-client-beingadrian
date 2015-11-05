//
//  ServerHelper.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/29/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import Gloss


typealias GetTripsCallback = (jsonTripStructs: [JSONTripStruct]?) -> Void

class APIClient {
    
    // MARK: Properties
    
    let urlString: String
    let usersURL: String
    let tripsURL: String
    
    // authorization
    let authString = "Basic " + "beingadrian:abc123".toBase64()
    
    // initialization
    init() {
        
        self.urlString = "http://127.0.0.1:5000/"
        self.usersURL = self.urlString + "users/"
        self.tripsURL = self.urlString + "trips/"

    }
    
    // MARK: Methods
    
    func postUser(username: String, password: String) {

        // jsonify user data
        let content = ["username": username, "password": password]
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(content, options: NSJSONWritingOptions(rawValue: 0))
        
        // url settings
        let url = NSURL(string: usersURL)!
        
        let urlRequest = NSMutableURLRequest(URL: url)
        urlRequest.HTTPMethod = "POST"
        urlRequest.HTTPBody = jsonData
        urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
        
        // iniitate session
        let session = NSURLSession.sharedSession()
        
        let postTask = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) in
            
            if let response = response {
                print(response)
            }
        }
        
        postTask.resume()
        
    }
    
    func postTrip(trip: Trip) {
        
        // jsonify trip
        var jsonWaypointStructs: [JSONWaypointStruct] = []
        for waypoint in trip.waypoints!.array as! [Waypoint] {
            let longitude = waypoint.longitude as! Double
            let latitude = waypoint.latitude as! Double
            let jsonWaypointStruct = JSONWaypointStruct(name: waypoint.name!, longitude: longitude, latitude: latitude, id: waypoint.id!, lastUpdate: NSDate().toString())
            jsonWaypointStructs.append(jsonWaypointStruct)
        }
        
        let jsonTripStruct = JSONTripStruct(name: trip.name!, id: trip.id!, waypoints: jsonWaypointStructs, lastUpdate: NSDate().toString())
        let content = jsonTripStruct.toJSON()!
        
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(content, options: NSJSONWritingOptions(rawValue: 0))
        
        // url settings
        let url = NSURL(string: tripsURL)!
        
        let urlRequest = NSMutableURLRequest(URL: url)
        urlRequest.HTTPMethod = "POST"
        urlRequest.HTTPBody = jsonData
        urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.setValue(authString, forHTTPHeaderField: "Authorization")
        
        // initiate session
        let session = NSURLSession.sharedSession()
        
        let postTask = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) in
            
            if let response = response {
                print(response)
            }
            
        }
        
        postTask.resume()
        
    }
    
    func getTrips(completion: GetTripsCallback) {
        
        // url settings 
        let url = NSURL(string: tripsURL)!
        
        let urlRequest = NSMutableURLRequest(URL: url)
        urlRequest.HTTPMethod = "GET"
        urlRequest.setValue(authString, forHTTPHeaderField: "Authorization")
        
        // initiate session
        let session = NSURLSession.sharedSession()
        
        let getTask = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) in
            
            if let data = data {
                do {
                    let jsonArray = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) as! [JSON]
                    
                    let jsonTripStructs = JSONTripStruct.modelsFromJSONArray(jsonArray)
                    
                    if let jsonTripStructs = jsonTripStructs {
                        completion(jsonTripStructs: jsonTripStructs)
                    } else {
                        completion(jsonTripStructs: nil)
                    }
                    
                } catch {
                    fatalError("Error fetchng JSON object: \(error)")
                }
            } else {
                completion(jsonTripStructs: nil)
            }
            
        }
        
        getTask.resume()
        
    }
    
    func deleteTripWithID(tripID: String) {
        
        // add trip id to the url ('/trips/ + tripID')
        let url = NSURL(string: tripsURL+tripID)!
        
        let urlRequest = NSMutableURLRequest(URL: url)
        urlRequest.HTTPMethod = "DELETE"
        urlRequest.setValue(authString, forHTTPHeaderField: "Authorization")
        
        // initiate session
        let session = NSURLSession.sharedSession()
        
        let deleteTask = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) in
            
            if let response = response as? NSHTTPURLResponse {
                if response.statusCode == 200 {
                    let deletedTripIDs = DataHelper.sharedInstance.deletedTripsIDs
                    DataHelper.sharedInstance.deletedTripsIDs = deletedTripIDs.filter() {
                        (deletedTripID) in
                        
                        !deletedTripIDs.contains(tripID)
                    }
                }
            }
            
        }
        
        deleteTask.resume()
    }
    
    func putTrip(trip: Trip) {
        
        // jsonify trip
        var jsonWaypointStructs: [JSONWaypointStruct] = []
        for waypoint in trip.waypoints!.array as! [Waypoint] {
            let longitude = waypoint.longitude as! Double
            let latitude = waypoint.latitude as! Double
            let jsonWaypointStruct = JSONWaypointStruct(name: waypoint.name!, longitude: longitude, latitude: latitude, id: waypoint.id!, lastUpdate: NSDate().toString())
            jsonWaypointStructs.append(jsonWaypointStruct)
        }
        
        let jsonTripStruct = JSONTripStruct(name: trip.name!, id: trip.id!, waypoints: jsonWaypointStructs, lastUpdate: NSDate().toString())
        let content = jsonTripStruct.toJSON()!
        
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(content, options: NSJSONWritingOptions(rawValue: 0))
        
        // add trip id to the url ('/trips/ + tripID')
        let url = NSURL(string: tripsURL+trip.id!)!
        
        let urlRequest = NSMutableURLRequest(URL: url)
        urlRequest.HTTPMethod = "PUT"
        urlRequest.HTTPBody = jsonData
        urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.setValue(authString, forHTTPHeaderField: "Authorization")
        
        // initiate session
        let session = NSURLSession.sharedSession()
        
        let postTask = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) in
            
            if let response = response {
                print(response)
            }
            
        }
        
        postTask.resume()
        
    }
    
}