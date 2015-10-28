//
//  TripDetailViewController.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/19/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit

class TripDetailViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var tripDetailNavigationItem: UINavigationItem!
    @IBOutlet weak var waypointsTableView: UITableView!
    
    var trip: Trip!
    
    // core data
    let dataHelper = DataHelper()
    var waypoints: [Waypoint] = []
    var selectedWaypoint: Waypoint?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        tripDetailNavigationItem.title = trip.name
        
        // override trip
        trip = dataHelper.fetchTripWithObjectID(trip.objectID)
        
        // get waypoints
        dataHelper.moc.refreshAllObjects()
        waypoints = trip.waypoints?.allObjects as! [Waypoint]
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // update waypoints array after adding waypoint
        dataHelper.moc.refreshAllObjects()
        waypoints = trip.waypoints?.allObjects as! [Waypoint]
        waypointsTableView.reloadData()
        
    }
    
    func setup() {
        
        // waypoints table view setup
        waypointsTableView.delegate = self
        waypointsTableView.dataSource = self
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let waypointViewController = segue.destinationViewController as? WaypointViewController {
            waypointViewController.waypoint = selectedWaypoint
        }
        
        if let addWaypointViewController = segue.destinationViewController as? AddWaypointViewController {
            addWaypointViewController.trip = trip
        }
        
    }

    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    override func prefersStatusBarHidden() -> Bool { return true }

    
    // MARK: Actions
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        
        performSegueWithIdentifier("ToAddWaypoint", sender: self)
    
    }
    
}

extension TripDetailViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedWaypoint = waypoints[indexPath.row]
        
        performSegueWithIdentifier("ToWaypoint", sender: self)
        
    }
    
    
}

extension TripDetailViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return waypoints.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let waypoint = waypoints[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("WaypointCell") as! WaypointCell
        
        cell.waypointNameLabel.text = waypoint.name
        
        return cell
        
    }
    
}





