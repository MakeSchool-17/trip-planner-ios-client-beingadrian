//
//  ServerHelper.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/29/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation


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
        
        // create waypoint data
        var waypointArray: [AnyObject] = []
        for waypoint in trip.waypoints! {
            
            if let waypoint = waypoint as? Waypoint {
                let dict: [String: AnyObject] = [
                    "name": waypoint.name!,
                    "longitude": waypoint.longitude!,
                    "latitude": waypoint.latitude!,
                    "trip": waypoint.trip!.name!
                ]
                
                waypointArray.append(dict)
            }
            
        }
        
        // create trip data
        let content: [String: AnyObject] = [
            "name": trip.name!,
            "waypoints": waypointArray
        ]
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
    
    func getTrips() {
        
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
                let jsonOptional: AnyObject! = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
                
                print(jsonOptional.valueForKeyPath("name")!)
                print(jsonOptional.valueForKeyPath("waypoints")!)
                
                if let json = jsonOptional! as? Dictionary<String, AnyObject> {
                    print(json)
                }
            } catch {
                fatalError("Error fetchng JSON object: \(error)")
            }
            
        }
        
        getTask.resume()
        
    }
    
}