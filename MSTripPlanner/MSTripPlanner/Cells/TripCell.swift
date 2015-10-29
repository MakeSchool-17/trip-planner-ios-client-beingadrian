//
//  TripCell.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/23/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit

class TripCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var tripNameLabel: UILabel!
    
    
    // MARK: Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
