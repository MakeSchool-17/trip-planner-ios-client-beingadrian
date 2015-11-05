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
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    
    var trip: Trip!
    
    var waypoints: [Waypoint] = []
    var selectedWaypoint: Waypoint?
    
    
    // MARK: Base methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        tripDetailNavigationItem.title = trip.name
        
        // initial waypoints retrieval
        waypoints = trip.waypoints?.array as! [Waypoint]
        
        // gesture recognizer
        let longPress = UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognized")
        waypointsTableView.addGestureRecognizer(longPress)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // update waypoints array after adding waypoint
        waypoints = trip.waypoints?.array as! [Waypoint]
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

    
    // MARK: Actions
    
    @IBAction func longPressGestureRecognized() {
        
        if !waypointsTableView.editing {
            rightBarButtonItem.title = "Done"
            waypointsTableView.setEditing(true, animated: true)
        }
        
    }
    
    @IBAction func rightBarButtonPressed(sender: UIBarButtonItem) {
        
        if waypointsTableView.editing {
            waypointsTableView.setEditing(false, animated: true)
            rightBarButtonItem.title = "Add"
        } else {
            performSegueWithIdentifier("ToAddWaypoint", sender: self)
        }
        
    }
    
}

extension TripDetailViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedWaypoint = waypoints[indexPath.row]
        
        performSegueWithIdentifier("ToWaypoint", sender: self)
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            let waypointToDelete = waypoints[indexPath.row]
            
            // delete waypoint from core data
            DataHelper.sharedInstance.deleteWaypointWithID(waypointToDelete.objectID)
            
            waypoints = trip.waypoints?.array as! [Waypoint]
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
            
            // update trip lastUpdated
            trip.lastUpdate = NSDate()
            
        }
        
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
        
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        let itemToMove = waypoints[sourceIndexPath.row]
        waypoints.removeAtIndex(sourceIndexPath.row)
        waypoints.insert(itemToMove, atIndex: destinationIndexPath.row)
        
        trip.waypoints = NSOrderedSet(array: waypoints)
        
        do {
            try DataHelper.sharedInstance.moc.save()
        } catch {
            fatalError("Error saving waypoints array as NSSet: \(error)")
        }
        
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





