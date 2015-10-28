//
//  PlannedTripsViewController.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/19/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit

class PlannedTripsViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var plannedTripsTableView: UITableView!
    
    var trips: [Trip] = []
    var selectedTrip: Trip?
    
    
    // MARK: Base Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        // initial trips retrieval
        trips = DataHelper.sharedInstance.fetchTrips()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // update trips
        trips = DataHelper.sharedInstance.fetchTrips()
        
        // reload table view to sync new data after adding trip
        plannedTripsTableView.reloadData()
        
    }

    func setup() {
        
        // access trips (initial)
        trips = DataHelper.sharedInstance.fetchTrips()
        
        // table view
        plannedTripsTableView.delegate = self
        plannedTripsTableView.dataSource = self
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let tripDetailViewController = segue.destinationViewController as? TripDetailViewController {
            tripDetailViewController.trip = selectedTrip
        }
        
    }
    
    // other methods
    
    override func prefersStatusBarHidden() -> Bool { return true }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    
    // MARK: Actions
    
    @IBAction func addBarButtonPressed(sender: UIBarButtonItem) {
        
        performSegueWithIdentifier("ToAddTrip", sender: self)
        
    }
    
}

extension PlannedTripsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedTrip = trips[indexPath.row]
        
        performSegueWithIdentifier("ToTripDetail", sender: self)
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == .Delete) {
            
            let tripToDelete = trips[indexPath.row]
            
            // delete from core data
            DataHelper.sharedInstance.deleteTripWithObjectID(tripToDelete.objectID)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
            
            trips = DataHelper.sharedInstance.fetchTrips()
        }
        
    }
    
}

extension PlannedTripsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataHelper.sharedInstance.fetchTrips().count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TripCell") as! TripCell
        
        let trip = trips[indexPath.row]
        
        cell.tripNameLabel.text = trip.name
        
        return cell
        
    }
    
}