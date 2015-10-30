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
    
}
