//
//  NavigationDecorator.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/28/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation
import UIKit


class BarDecorator {
    
    var navigationBar: UINavigationBar
    
    init(navigationBar: UINavigationBar) {
        self.navigationBar = navigationBar
    }
    
    func changeBarTintColor() {
        
        navigationBar.barTintColor = UIColor.whiteColor()
        
    }
    
    func setTitleFont() {
        
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.grayColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 18)!]
        
    }
    
}