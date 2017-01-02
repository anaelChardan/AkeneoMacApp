//
//  ContainerNetwork.swift
//  AkeneoMacApp
//
//  Created by Clément GARBAY on 02/01/2017.
//  Copyright © 2017 Ananas-Mac. All rights reserved.
//

import Cocoa
import EVReflection

class ContainerNetwork: EVObject {
    var name: String?
    var values: [String:String]?
        
    override func setValue(_ value: Any!, forUndefinedKey key: String) {
        self.name = key
        
        if let dict = value as? NSDictionary {
            self.values = [:]
            for (key, value) in dict {
                self.values?[key as? String ?? ""] = value as? String
            }
        }
    }
}
