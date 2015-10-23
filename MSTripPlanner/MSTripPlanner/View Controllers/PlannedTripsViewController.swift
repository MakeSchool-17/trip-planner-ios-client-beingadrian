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
    
    
    
    // MARK: Base Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    func setup() {
        
        // insert setup code here
        
    }
    
    override func prefersStatusBarHidden() -> Bool { return true }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    @IBAction func addBarButtonPressed(sender: UIBarButtonItem) {
        
        performSegueWithIdentifier("ToAddTrip", sender: self)
        
    }
    
}
