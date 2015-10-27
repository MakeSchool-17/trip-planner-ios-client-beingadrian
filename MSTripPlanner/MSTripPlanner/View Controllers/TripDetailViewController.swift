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
    
    var trip: Trip?
    
    // core data
    let dataHelper = DataHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        if let trip = trip {
            tripDetailNavigationItem.title = trip.name
        }
        
    }
    
    func setup() {
        
        // table view setup
        waypointsTableView.delegate = self
        waypointsTableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    override func prefersStatusBarHidden() -> Bool { return true }

    
    // MARK: Actions
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        
        performSegueWithIdentifier("ToAddWaypoint", sender: self)
    
    }
    
}

extension TripDetailViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // insert code here
        
    }
    
    
}

extension TripDetailViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return dataHelper.fetchWaypoints().count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("WaypointCell") as! WaypointCell
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        
        header.textLabel?.text = "Test"
        
    }
    
}





