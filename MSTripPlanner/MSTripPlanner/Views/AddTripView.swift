//
//  AddTripView.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/23/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit


class AddTripView: UIView {

    // MARK: - Properties

    @IBOutlet weak var textField: UITextField!
    
    var delegate: AddTripUIViewDelegate?
    
    
    // MARK: - Actions
    
    @IBAction func textFieldEditingChanged(sender: UITextField) {
        
        let inputTextIsValid = sender.text?.characters.count != 0
    
        delegate?.textInputIsValid(self, isValid: inputTextIsValid)
        
    }

}

protocol AddTripUIViewDelegate {
    
    func textInputIsValid(addTripView: AddTripView, isValid: Bool) -> Void
    
}
