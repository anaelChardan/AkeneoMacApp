//
//  AppDelegate.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 27/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Cocoa

extension Array where Element: Equatable {
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}

//TODO MUST USE A Dependency Injector
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
}

