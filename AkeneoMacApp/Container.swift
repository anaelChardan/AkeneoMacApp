//
//  Container.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 29/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Cocoa

//Container represented by StrictTypes

class Container: NSObject {
    var Id: String = ""
    var Names: [String] = []
    var Image: String = ""
    var ImageID: String = ""
    var Command: String = ""
    var Mounts: [[String: String]] = [[:]]
    
    init(container: [String: AnyObject]) {
        self.Id = (container["Id"]!) as! String
        self.Names = (container["Names"]) as! [String]
        self.Image = (container["Image"]) as! String
        self.ImageID = (container["ImageID"]) as! String
        self.Command = (container["Command"]) as! String
        self.Mounts = Utils.arrayOfStringAnyToArrayOfStringString(arrayToConvert: (container["Mounts"]!) as! [[String: AnyObject]])
    }
    
    func getFolder() -> String {
        return "plop"
    }
}
