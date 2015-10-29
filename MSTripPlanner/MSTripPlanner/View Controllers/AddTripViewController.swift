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
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    
    // MARK: Base methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
        // design implementations
        let navDecorator = BarDecorator(navigationBar: navigationBar)
        navDecorator.changeBarTintColor()
        navDecorator.setTitleFont()
        
    }

    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    func setup() {
        
        addTripView.delegate = self
        
        // disable add button until user fills the field
        addBarButtonItem.enabled = false
        
    }
    
    
    // MARK: Actions

    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func addBarButtonPressed(sender: UIBarButtonItem) {
        
        // access user input text
        guard let tripName = addTripView.textField.text else { return }
        
        // store trip to core data
        DataHelper.sharedInstance.addTripWithName(tripName)
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}

extension AddTripViewController: AddTripUIViewDelegate {
    
    func textInputIsValid(addTripView: AddTripView, isValid: Bool) {
        
        if isValid {
            addBarButtonItem.enabled = true
        } else {
            addBarButtonItem.enabled = false
        }
        
    }
    
}
