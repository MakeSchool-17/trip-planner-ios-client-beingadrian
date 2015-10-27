//
//  WaypointCell.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/27/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import UIKit

class WaypointCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var waypointNameLabel: UILabel!
    
    
    // MARK: Base methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
