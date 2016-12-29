//
//  Utils.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 29/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Cocoa

class Utils: NSObject {
    static func StringAnyObjectToStringString(dictionnary: [String: AnyObject]) -> [String: String] {
        var returnValue: [String: String] = [:]
        
        for (n, l) in dictionnary {
            returnValue[n] = String(describing: l)
        }
        
        return returnValue
    }
    
    static func arrayOfStringAnyToArrayOfStringString(arrayToConvert: [[String:AnyObject]]) -> [[String: String]] {
        return arrayToConvert.map { value in self.StringAnyObjectToStringString(dictionnary: value)}
    }
}
