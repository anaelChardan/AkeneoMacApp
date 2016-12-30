//
//  Container.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 29/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Cocoa

//Container represented by primitive Types wrapped
class Container: NSObject {
    var Id: String = ""
    var Names: [String] = []
    var Image: String = ""
    var ImageID: String = ""
    var Command: String = ""
    var Mounts: [[String: String]] = [[:]]
    var Ports: [[String: String]] = [[:]]
    var NetworkSettings: [String:[String:[String:String]]]? = nil

    override var description: String {
        return getTerminalFolder()
    }
    
    init(container: [String: AnyObject]) {
        super.init()
        
        self.Id = (container["Id"]!) as! String
        self.Names = (container["Names"]) as! [String]
        self.Image = (container["Image"]) as! String
        self.ImageID = (container["ImageID"]) as! String
        self.Command = (container["Command"]) as! String
        self.Mounts = ((container["Mounts"]!) as! [[String: AnyObject]]).toStringStringElementArray()
        self.Ports = ((container["Ports"]!) as! [[String: AnyObject]]).toStringStringElementArray()
        self.setNetwork(preConvertedArray: ((container["NetworkSettings"]!) as! [String: [String: [String: AnyObject]]]))
    }
    
    private func setNetwork(preConvertedArray: [String: [String: [String: AnyObject]]])
    {
        var preConvertedArrayCopy: [String: [String: [String: String]]] = [:]
        
        for (key, value) in preConvertedArray {
            preConvertedArrayCopy[key] = [:]
            for (secondLevelKey, secondLevelValue) in value {
                preConvertedArrayCopy[key]?[secondLevelKey] = secondLevelValue.toStringString()
            }
        }
        
        self.NetworkSettings = preConvertedArrayCopy
    }
    
    func getFolder() -> String {
        return self.Mounts.first { (mountInfo: [String: String]) -> Bool in
            return (mountInfo["Destination"]!) == "/home/docker/pim"
        }!["Source"]!
    }
    
    func getTerminalFolder() -> String {
        return getFolder().lastPartAfter(separatedBy: "/")!
    }
    
    func getPublicPort(privatePort: String) -> String
    {
        return self.Ports.first { (currentPort: [String: String]) -> Bool in
            return (currentPort["PrivatePort"]!) == privatePort
            
        }!["PublicPort"]!
    }
}
