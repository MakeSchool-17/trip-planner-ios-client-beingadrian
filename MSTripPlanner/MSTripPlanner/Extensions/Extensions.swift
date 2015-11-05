//
//  StringExtensions.swift
//  MSTripPlanner
//
//  Created by Adrian Wisaksana on 10/29/15.
//  Copyright © 2015 BeingAdrian. All rights reserved.
//

import Foundation


extension String {
    
    func toBase64() -> String {
        
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        let base64EncodedString = data!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        return base64EncodedString
        
    }
    
    func toNSDate() -> NSDate? {
        
        guard let date = NSDateFormatter().dateFromString(self) else { return nil }
        
        return date
        
    }
    
}


extension NSDate {
    
    func toString() -> String {
        
        let string = NSDateFormatter().stringFromDate(self)
        
        return string
    }
    
    // Code below is inspired from http://stackoverflow.com/questions/26198526/nsdate-comparison-using-swift

    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {

        var isGreater = false
        
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending {
            isGreater = true
        }
        
        return isGreater
    }
    
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {

        var isLess = false
        
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending {
            isLess = true
        }
        
        return isLess
    }
    
}