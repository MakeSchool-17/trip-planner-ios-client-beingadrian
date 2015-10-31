//
//  ServerHelper.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/29/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation


typealias GetTripsCallback = (trips: [TripJSON]) -> Void

class APIClient {
    
    // MARK: Properties
    
    static let urlString = "http://127.0.0.1:5000/"
    static let usersURL = urlString + "users/"
    static let tripsURL = urlString + "trips/"
    
    // authorization
    static let authString = "Basic " + "beingadrian:abc123".toBase64()
    
    
    // MARK: Methods
    
    static func postUser(username: String, password: String) {

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
    
    static func postTrip(trip: Trip) {
        
        // create json data
        let tripJSON = TripJSON(trip: trip)
        let content = tripJSON.toJSON()
        
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
    
    static func getTrips(completion: GetTripsCallback) {
        
        // url settings 
        let url = NSURL(string: tripsURL)!
        
        let urlRequest = NSMutableURLRequest(URL: url)
        urlRequest.HTTPMethod = "GET"
        urlRequest.setValue(authString, forHTTPHeaderField: "Authorization")
        
        // initiate session
        let session = NSURLSession.sharedSession()
        
        let getTask = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) in
            
            do {
                let jsonTrips = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as! [JSON]
                
                // get managed object context
                let moc = DataHelper.sharedInstance.moc
                
                for jsonTrip in jsonTrips as [JSON] {
                    _ = Trip(context: moc, jsonTrip: jsonTrip)
                }
                
                try! moc.save()
                
                
                
            } catch {
                fatalError("Error fetchng JSON object: \(error)")
            }
            
        }
        
        getTask.resume()
        
    }
    
}