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
    @IBOutlet var addTripView: AddTripView!
    
    // core data
    let dataHelper = DataHelper()
    
    
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
        
        // set UIView delegate
        addTripView.delegate = self
        
        // disable add button until user fills the field
        addBarButtonItem.enabled = false
        
    }
    
    override func prefersStatusBarHidden() -> Bool { return true }
    
    
    // MARK: Actions

    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func addBarButtonPressed(sender: UIBarButtonItem) {
        
        // access user input
        guard let tripName = addTripView.textField.text else { return }
        
        // store trip to core data
        dataHelper.seedTripWithName(tripName)
        
        // dismiss
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}

extension AddTripViewController: AddTripUIViewDelegate {
    
    func textInputIsValid(isValid: Bool) {
        
        if isValid {
            addBarButtonItem.enabled = true
        } else {
            addBarButtonItem.enabled = false
        }
        
    }
    
}
