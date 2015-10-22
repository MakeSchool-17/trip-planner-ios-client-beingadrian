//
//  AddTripViewController.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/19/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit
import CoreData


class AddTripViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    
    
    // MARK: Base methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func setup() {
        
        // disable add button until user fills the field
        addBarButtonItem.enabled = false
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    // MARK: Actions

    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func addBarButtonPressed(sender: UIBarButtonItem) {
        
        // insert code here
        
    }
    
}
