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
    
    // core data
    let dataHelper = DataHelper()
    
    var trips: [Trip] = []
    var selectedTrip: Trip?
    
    
    // MARK: Base Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // access trips (to update trips)
        trips = dataHelper.fetchTrips()
        
        // reload table view to sync new data after adding trip
        plannedTripsTableView.reloadData()
        
    }

    func setup() {
        
        // access trips (initial)
        trips = dataHelper.fetchTrips()
        
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
    
}

extension PlannedTripsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataHelper.fetchTrips().count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TripCell") as! TripCell
        
        let trip = trips[indexPath.row]
        
        cell.tripNameLabel.text = trip.name
        
        return cell
        
    }
    
}