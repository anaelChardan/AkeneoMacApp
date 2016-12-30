//
//  AkeneoContainer.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 29/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Cocoa

class AkeneoContainer: NSObject {
    var container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func open() {
        NSWorkspace.shared().open(URL(string: "http://localhost:\(self.container.getPublicPort(privatePort: "80"))")!)
    }
    
    func initalize() {
        print("initalize")
    }
    
    func shutdown() {
        print("shutdown")
    }
}
