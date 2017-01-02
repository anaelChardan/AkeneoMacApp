//
//  Port.swift
//  AkeneoMacApp
//
//  Created by Clément GARBAY on 02/01/2017.
//  Copyright © 2017 Ananas-Mac. All rights reserved.
//

import Cocoa
import EVReflection

class ContainerPort: EVObject {
    var ip: String?
    var privatePort: NSNumber?
    var publicPort: NSNumber?
    var type: String?
  
    override public func propertyMapping() -> [(String?, String?)] {
        return [
            ("ip","IP")
        ]
    }
}
