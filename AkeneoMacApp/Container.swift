//
//  Container.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 29/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Cocoa
import EVReflection

class Container: EVObject {
    var id: String?
    var names: [String]?
    var image: String?
    var imageId: String?
    var command: String?
    var ports: [ContainerPort]? = []
    var state: String?
    var status: String?
    var networkSettings: ContainerNetworkSettings?
    var mounts: [ContainerMount]?
    var pimFolder: String? {
        get {
            if let mounts = self.mounts {
                let sourceFolder = mounts.first { (mount: ContainerMount) -> Bool in
                    return mount.destination! == "/home/docker/pim"
                    }?.source
                return sourceFolder?.lastPartAfter(separatedBy: "/")
            }
            return nil
        }
    }

    override public func propertyMapping() -> [(String?, String?)] {
        return [
            ("imageId","ImageID")
        ]
    }
    
    override var description: String {
        return self.pimFolder ?? ""
    }
    
    func getPublicPort(privatePort: NSNumber) -> NSNumber? {
        if let ports = self.ports {
            return ports.first { (currentPort: ContainerPort) -> Bool in
                return currentPort.privatePort == privatePort
            }?.publicPort
        }
        return .none
    }
    
    func getMainNetwork() -> String? {
        if let networkSettings = self.networkSettings {
            return networkSettings.networks.first?.name
        }
        return .none
    }
}
